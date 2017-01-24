import Dict
import Test.QuickCheck
import Data.Maybe

-- If we add a key and value, when we search for the key we get back that
-- value.
prop_addSearch :: (Ord k, Eq v) => k -> v -> Dict k v -> Bool
prop_addSearch k v dict = v == vn where
  Just vn = search k (add k v dict)

-- If we add a value for a key k1, then add a value for a different key k2,
-- when we search for the value of k1 we get back the value we added.
prop_addAddSearch_k :: (Ord k, Eq v) => k -> v -> k -> v -> Dict k v -> Property
prop_addAddSearch_k k1 v1 k2 v2 dict = property (vn == v1) where
  Just vn = search k1 (add k2 v2 (add k1 v1 dict))

-- If we add a value [v1] for a key [k], then add a value [v2] for the same
-- key, when we search for the value of [k] we get back [v2].
prop_addAddSearch_v :: (Ord k, Eq v) => k -> v -> v -> Dict k v -> Bool
prop_addAddSearch_v k1 v1 v2 dict = vn == v2 where
  Just vn = search k1 (add k1 v2 (add k1 v1 dict))

prop_removeSearch :: (Ord k, Eq v) => k -> Dict k v -> Bool
prop_removeSearch k dict = isNothing (search k (remove k dict))

tests :: IO ()
tests = do
    quickCheck (prop_addSearch :: Int -> Int -> Dict Int Int -> Bool)
    quickCheck (prop_addSearch :: Int -> String -> Dict Int String -> Bool)
    quickCheck (prop_addAddSearch_k :: Int -> Int -> Int -> Int -> Dict Int Int -> Property)
    quickCheck (prop_addAddSearch_k :: Int -> String -> Int -> String -> Dict Int String -> Property)
    quickCheck (prop_addAddSearch_v :: Int -> Int -> Int -> Dict Int Int -> Bool)
    quickCheck (prop_addAddSearch_v :: Int -> String -> String -> Dict Int String -> Bool)
    quickCheck (prop_removeSearch :: Int -> Dict Int Int -> Bool)
    quickCheck (prop_removeSearch :: Int -> Dict Int String -> Bool)

main :: IO ()
main = do
  tests
