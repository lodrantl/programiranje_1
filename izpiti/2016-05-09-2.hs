import Data.List
data Drevos = Drevos String [Drevos] deriving Show
data Drevo a = Drevo a [Drevo a] deriving Show

primer = Drevo 18 [
  Drevo 12 [],
  Drevo 10 [Drevo 5 []],
  Drevo 8 [Drevo 1 [], Drevo 3 []]
  ]

vsota :: Num a => Drevo a -> a
vsota (Drevo x ds) = x + sum (map vsota ds)

jeKopica:: Ord a => Drevo a -> Bool
jeKopica (Drevo x ds)= all (jeKopica' x) ds where
  jeKopica' x (Drevo y ds) = x > y && jeKopica' x (Drevo y ds)

odstraniMax :: Ord a => Drevo a -> (a, Maybe (Drevo a))
odstraniMax (Drevo x []) = (x, Nothing)
odstraniMax (Drevo x ds) = (x, Just (Drevo x' ds')) where
  dobix (Drevo x _) = x
  dobids (Drevo _ ds) = ds
  ordered = sortOn dobix ds
  x' = dobix (last ordered)
  ds' = dobids (last ordered) ++ (init ordered)

padajociElementi :: Ord a => Drevo a -> [a]

padajociElementi d = padajociElementi' (Just d) where
  padajociElementi' Nothing = []
  padajociElementi' (Just d) = (fst c):(padajociElementi' (snd c)) where
    c = odstraniMax d
