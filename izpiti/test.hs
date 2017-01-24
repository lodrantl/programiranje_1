module Izpit where

import Data.List

data Drevo = Drevo String [Drevo] deriving Show

veriga :: String -> Drevo -> [String]
veriga iskano d = reverse (veriga' iskano d) where
  endsWith i x = last x == i
  firstOrNone [] = []
  firstOrNone x = head x
  veriga' :: String -> Drevo -> [String]
  veriga' _ (Drevo ime []) = [ime]
  veriga' i (Drevo ime listi) = ime: firstOrNone (filter (endsWith i) (map (veriga' i) listi))

ekipa :: String -> Drevo -> [String]
ekipa i1 d@(Drevo i2 l)
  | i1 == i2 = sort (zdruzi d)
  | otherwise = concatMap (ekipa i1) l where
    zdruzi (Drevo ime []) = [ime]
    zdruzi (Drevo ime listi) = ime : concatMap zdruzi listi

jeSprosceno :: [String] -> Drevo -> Bool
jeSprosceno xs d =  all (nimaSefa xs d) xs where
  nimaSefa' [_] _ = True
  nimaSefa' v ys = notElem (v !! 1) ys
  nimaSefa ys t y = nimaSefa' (veriga y t) ys

obrekovanje :: [String] -> Drevo -> (Maybe String)
obrekovanje xs (Drevo ime _) | elem ime xs = Nothing
obrekovanje xs d = Just (head (presek verige)) where
  v x y = veriga y x
  verige = map (v d) xs
  presek :: [[String]] -> [String]
  presek [x] = x
  presek (x:s) = intersect x (presek s)
