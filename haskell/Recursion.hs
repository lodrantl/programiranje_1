{-
 - Exercise 2.2: Functions and recursion
 -}

-- **
-- 'range a b' computes a list of numbers from a to b, including the boundaries.
-- It should be defined recursively.
--
-- Example:
-- ghci> range 5 10
-- [5,6,7,8,9,10]
-- ghci> range 10 5
-- []
range :: Int -> Int -> [Int]
range i j
  | i >= j = [i]
  | otherwise = i : range (i+1) j

-- **
-- 'insert x lst i' inserts 'x' into the list 'lst' at index 'i'.
-- 'i' has to be a valid index.
-- It should be defined by recursion.
--
-- Example:
-- ghci> insert 7 [1,2,3,4,5] 2
-- [1,2,7,3,4,5]
insert :: Int -> [Int] -> Int -> [Int]
insert x l i
  | i == 0 = x : l
  | otherwise = head l : insert x  (tail l) (i - 1)

-- ***
-- 'couples lst' pairs each two consecutive elements in 'lst' into a couple.
-- If 'lst' is of odd length, the last element is omitted.
-- This function is to be defined by recursion.
--
-- Example:
-- ghci> couples ["Toni", "Majda", "Andrej", "Boris", "Petra"]
-- [("Toni","Majda"),("Andrej","Boris")]
couples :: [a] -> [(a,a)]
couples list
  | length list <= 1 = []
  | otherwise = (list !! 0, list !! 1) : (couples $ drop 2 list)

-- **
-- 'nonDecreasing lst' checks that the elements of 'lst' are in non decreasing order.
--
-- Example:
-- ghci> nonDecreasing [-1,2,5,5,5,7,7]
-- True
-- ghci> nonDecreasing [-1,2,5,3,5,7,7]
-- False
nonDecreasing lst
  | length lst <= 1 = True
  | otherwise = (lst !! 0) <= (lst !! 1) && nonDecreasing(tail lst)

-- **
-- A Stirling number of the second kind (or Stirling partition number), denoted
-- by S(n, k) is the number of ways to partition a set of n objects into k
-- non-empty subsets.
-- It can be defined recursively as follows:
-- S(n + 1, k) = k · S(n, k) + S(n, k - 1) for k > 0
-- The base cases are:
-- S(n, 0) = S(0, n) = 0 for n > 0, and
-- S(0, 0) = 1
--
-- Example:
-- ghci> stirling2 5 2
-- 15
stirling2 :: Int -> Int -> Int
stirling2 0 0 = 1
stirling2 n 0 = 0
stirling2 0 n = 0
stirling2 n k = k * (stirling2 (n-1) k) + (stirling2 (n-1) (k-1))

-- ***
-- Write a function 'cantor n' that computes the n-th approximation of the
-- Cantor set as a string of length 3^n.
--
-- Example:
-- ghci> cantor 0
-- "*"
-- ghci> cantor 1
-- "* *"
-- ghci> cantor 2
-- "* *   * *"
cantor :: Int -> String
cantor 0 = "*"
cantor n = m ++ replicate (3^(n-1)) ' ' ++ m where m = cantor(n-1)

-- **
-- 'myGcd n m' calculates the greatest common divisor (gcd) of m and n.
-- We assume the convention that gcd 0 0 = 0.
--
-- Example:
-- ghci> myGcd 50 70
-- 10

myGcd :: Int -> Int -> Int
myGcd 0 0 = 0
myGcd n m
  | n < m = myGcd m n
  | n `mod` m == 0 = m
  | otherwise = myGcd m (n `mod` m)

-- ****
-- 'permutations lst' builds a list of all the permutations of 'lst'.
--
-- Example:
-- ghci> permutations [1,2,3]
-- [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
delete :: Eq a  => a -> [a] -> [a]
delete x lst = [y | y <- lst, y /= x]
permutations :: Eq a => [a] -> [[a]]
permutations lst
  | length lst == 1 = [lst]
  | otherwise = [ x:ys | x <- lst, ys <- permutations(delete x lst)]


-- ***
-- We want to solve the puzzle of the Tower of Hanoi for 'n' discs on 3 rods,
-- assuming that initially all discs are on the first rod.
-- 'hanoi n a b' is defined only for n, a, b such that 1 ≤ a, b ≤ 3 ∧ a ≠ b.
-- It returns a list of couples representing the moves that get the 'n' discs
-- from rod 'a' to rod 'b'.
--
-- Example:
-- ghci> hanoi 3 1 3
-- [(1,3),(1,2),(3,2),(1,3),(2,1),(2,3),(1,3)]
-- ghci> hanoi 4 1 re3
-- [(1,2),(1,3),(2,3),(1,2),(3,1),(3,2),(1,2),(1,3),(2,3),(2,1),(3,1),(2,3),(1,2),(1,3),(2,3)]
hanoi :: Int -> Int -> Int -> [(Int, Int)]
hanoi 1 a b = [(a,b)]
hanoi n a b = hanoi (n-1) a c ++ [(a,b)] ++ hanoi (n-1) c b where c = 6 - a - b
