{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
-- We implement dictionaries using naïve binary search trees.
module Dict
  ( Dict
  , empty
  , add
  , search
  , remove
  , fromList
  , internalTests
  )
  where

  import Test.QuickCheck
  import Control.Monad

  data Tree a = Leaf | Node (Tree a) a (Tree a)  deriving (Eq, Show)

  type Dict k v = Tree (k, v)

  -- An empty dictionary.
  empty :: Dict k v
  empty = Leaf

  test = Node (Node Leaf (0,5) Leaf) (1,3) (Node (Node Leaf (2,5) Leaf) (3,4) Leaf)

  -- [add k v d] associates [v] to [k] in a dictionary [d].
  add :: Ord k => k -> v -> Dict k v -> Dict k v
  add k v Leaf = Node Leaf (k,v) Leaf
  add k v (Node l (ko,vo) r)
    | k == ko = (Node l (k,v) r)
    | k < ko = (Node (add k v l) (ko,vo) r)
    | k > ko = (Node l (ko,vo) (add k v r))

  -- [search k d] finds the value associated to a key [k], if it is present in a
  -- dictionary.
  search :: Ord k => k -> Dict k v -> Maybe v

  search k Leaf = Nothing
  search k (Node l (ko,vo) r)
    | k == ko = Just vo
    | k < ko = search k l
    | k > ko = search k r

  -- [insert_sub_r sub t] inserts [sub] as a the rightmost subtree in [t].
  insertSubR :: Tree a -> Tree a -> Tree a
  insertSubR a Leaf = a
  insertSubR a (Node l v r) = Node l v (insertSubR a r)

  -- [remove k d] returns [d] where [k] does not have an associated value.
  remove :: Ord k => k -> Dict k v -> Dict k v
  remove k Leaf = Leaf
  remove k tree@(Node l (ko,vo) r)
    | k < ko = Node (remove k l) (ko, vo) r
    | k > ko = Node l (ko, vo) (remove k r)
    | k == ko = remove' k tree where
      remove' k (Node l _ Leaf) = l
      remove' k (Node Leaf _ r) = r
      remove' k (Node l _ r) = Node l (km,vm) (remove km r) where
        min' (Node Leaf v r) = v
        min' (Node l v r) = min' l
        (km,vm) = min' r


  -- Produce a dictionary from a list. The keys in the list are assumed to be
  -- without repetition.
  fromList :: Ord k => [(k,v)] -> Dict k v
  fromList a = addList a Leaf where
    addList :: Ord k => [(k,v)] -> Dict k v -> Dict k v
    addList [] tree = tree
    addList ((k,v):xs) tree = addList xs (add k v tree)

  depth :: Tree a -> Integer
  depth Leaf = 0
  depth (Node l _ r) = max (depth l) (depth r) + 1

  -- We provide a generator for random trees for QuickCheck.
  arbitraryTree :: (Arbitrary a) => Gen (Tree a)
  arbitraryTree = sized genTree
      where genTree n = case compare n 0 of
              LT -> return Leaf
              EQ -> return Leaf
              GT -> oneof [return Leaf,
                           liftM3 Node subtree arbitrary subtree]
                where subtree = genTree (n `div` 2)

  -- ...but we don't use it, because it does not generate search trees.
  -- instance Arbitrary a => Arbitrary (Tree a) where
  --   arbitrary = arbitraryTree

  -- Instead, here's a generator for search trees.

  -- Note that the reliability and significance of all the tests that use a
  -- generator G rely on the correctness of G. Here, we rely on [fromList] and
  -- thus on [add]. We could instead write a potentially complex generator.
  genSearchTree :: (Ord k, Arbitrary k, Arbitrary v) => Gen (Dict k v)
  genSearchTree = liftM fromList arbitrary

  instance (Ord k, Arbitrary k, Arbitrary v) => Arbitrary (Dict k v) where
      arbitrary = genSearchTree

  isSorted :: (Ord k) => Dict k v -> Bool
  isSorted d = isSortedBetween Nothing d Nothing where
    isSortedBetween _ Leaf _ = True
    isSortedBetween minK (Node l (k, _) r) maxK =
      minK <=? Just k && Just k <=? maxK &&
      isSortedBetween minK l (Just k) &&
      isSortedBetween (Just k) r maxK
    Nothing <=? _ = True
    _ <=? Nothing = True
    Just x <=? Just y = x <= y

  -- This should always hold if the generator uses [add] internally.
  prop_isSortedAdd :: Ord k => Dict k v -> k -> v -> Property
  prop_isSortedAdd d k v =
      collect (depth d) $ collect (isSorted d) $ (isSorted d) ==> (isSorted (add k v d))

  internalTests :: IO ()
  internalTests = do
    quickCheck (isSorted :: Dict Integer String -> Bool)
    quickCheck (isSorted :: Dict String Integer -> Bool)
    quickCheck (prop_isSortedAdd :: Dict Integer String -> Integer -> String -> Property)
    quickCheck (prop_isSortedAdd :: Dict String Integer -> String -> Integer -> Property)
