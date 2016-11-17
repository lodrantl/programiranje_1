{-
 - Exercise 1: Introduction to Haskell
 -}

-- penultimateElement l returns the second-to-last element of the list l
penultimateElement :: [a] -> a
penultimateElement l = last $ init l

-- get k l returns the k-th element in the list l
-- Example:
-- ghci> get 2 [0,0,1,0,0,0]
-- 1
get k l = l !! k

-- double l "doubles" the list l
-- Example:
-- ghci> double [1,2,3,3]
-- [1,1,2,2,3,3,3,3]
-- Hint: The concat function creates a list containing the elements of the lists in a list
double l = concat [[x,x] | x <- l]

-- divide k l divides the list l into a pair of a list of the first k elements
-- of l and the rest
-- Example:
-- ghci> divide 2 [1,1,1,2,2,2]
-- ([1,1],[1,2,2,2])
divide k l = (take k l, drop k l)

-- delete k l returns the list l with the k-th element removed
-- Example:
-- ghci> delete 3 [0,0,0,1,0,0,0]
-- [0,0,0,0,0,0]
delete k l = if k > 0 then head l:delete (k-1) (tail l) else tail l
delete' k l = h ++ tail t where (h, t) = divide k l
delete'' k l = let (h,t) = divide k l in h ++ tail t

-- slice i k l returns the sub-list of l from the i-th up to (excluding) the k-th element

-- Example:
-- ghci> slice 3 6 [0,0,0,1,2,3,0,0,0]
-- [1,2,3]
slice i k l = drop i $ take k l

-- insert x k l inserts x at index k into l
-- Example:
-- ghci> insert 2 5 [0,0,0,0,0,0]
-- [0,0,0,0,0,2,0]
insert x k l = h ++ [x] ++ t where (h,t) = divide k l

-- rotate n l rotates l to the left by n places
-- Example:
-- ghci> rotate 2 [1,2,3,4,5]
-- [3,4,5,1,2]
rotate n l = t ++ h where (h,t) = divide n l

-- remove x l returns a l with *all* occurances of x removed
-- Example:
-- ghci> remove 'a' "abrakadabra"
-- "brkdbr"
remove x l = [i | i <- l, i /= x]

-- isPalindrome is a predicate that checks if a list is a palindrome
-- Example:
-- ghci> isPalindrome [1,2,3,2,1]
-- True
-- ghci> isPalindrome [1,2,2,1]
-- True
-- ghci> isPalindrome [1,2,3]
-- False
isPalindrome l = l == reverse l

-- pointwiseMax l1 l2 returns the list of maximum elements in l1 and l2 at each
-- index, stopping at the shorter list of l1 and l2.
-- Example:
-- ghci> pointwiseMax [1,10,5,6] [2,3,7,4,8]
-- [2,10,7,6]
pointwiseMax l1 l2 = [maximum[l1 !! i, l2 !! i] | i <- [0..minimum [length l1, length l2] -1]]

-- secondLargest l returns the second largest element of l.
-- l has to contain at least two distinct elements!
-- Example:
-- ghci> secondLargest [1,10,5,6]
-- 6
secondLargest l = maximum [x | x <- l, x < maximum l]
