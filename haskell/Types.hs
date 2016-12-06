{-
 - Exercise set 3: Datatypes
 -}

-- Natural numbers
-- ===============

data Natural = Zero | Succ Natural deriving (Show)

-- 'add m n' returns the sum of natural numbers 'm' and 'n'

add :: Natural -> Natural -> Natural
add m Zero     = m
add m (Succ n) = add (Succ m) n

-- 'multiply m n' returns the product of natural numbers 'm' and 'n'

multiply :: Natural -> Natural -> Natural
multiply m Zero        = Zero
multiply Zero n        = Zero
multiply n (Succ Zero) = n
multiply m (Succ n)    = multiply (add m m) n

-- 'toNatural n' converts an integer 'n' into a natural number
--
-- Example:
-- ghci> toNatural 0
-- Zero
-- ghci> toNatural 2
-- Succ (Succ Zero)

toNatural :: Integer -> Natural
toNatural 0 = Zero
toNatural n = Succ (toNatural (n-1))

-- 'fromNatural n' converts a natural number 'n' to an integer
--
-- Example:
-- ghci> fromNatural Zero
-- 0
-- ghci> fromNatural (Succ (Succ Zero))
-- 2

fromNatural :: Natural -> Integer
fromNatural Zero = 0
fromNatural (Succ n) = 1 + fromNatural n



-- Trees
-- =====

-- Here we define the recursive datatype Tree. We will add more functions that
-- work on trees, like the sumTree example, which calculates the sum of the
-- elements of a tree.

data Tree a = Leaf | Node a (Tree a) (Tree a) deriving (Show)

sumTree :: Num a => Tree a -> a
sumTree Leaf                = 0
sumTree (Node x left right) = x + sumTree left + sumTree right

-- 'depth tr' returns the depth of a tree. Leaves have depth 0.
--
-- Example:
-- ghci> let d = Node 3 (Node 7 Leaf (Node 2 Leaf Leaf)) (Node 8 Leaf Leaf)
-- ghci> globina d
-- 3

depth :: Tree a -> Int

depth Leaf = 0
depth (Node x left right) = 1 + max (depth left) (depth right)

-- 'numberOfElements tr', for 'tr' of type 'Tree alpha' computes the number of
-- alpha's ("elements") in tr.
--
-- Example:
-- ghci> let tr = Node 3 (Node 7 Leaf (Node 2 Leaf Leaf)) (Node 8 Leaf Leaf)
-- ghci> numberOfElements tr
-- 4

numberOfElements :: Tree a -> Int

numberOfElements Leaf = 0
numberOfElements (Node x left right) = 1 + numberOfElements left + numberOfElements right

-- 'flip tr' swaps the left and right subtrees of each node in 'tr'
--
-- Example:
-- ghci> let tr = Node 3 (Node 7 Leaf (Node 2 Leaf Leaf)) (Node 8 Leaf Leaf)
-- ghci> flip tr
-- Node 3 (Node 8 Leaf Leaf) (Node 7 (Node 2 Leaf Leaf) Leaf)

flips :: Tree a -> Tree a
flips Leaf = Leaf
flips (Node x left right) = Node x (flips right) (flips left)

-- 'leftMost tr' returns the left-most element in 'tr'.
-- Example:
-- ghci> let tr = Node 3 (Node 7 Leaf (Node 2 Leaf Leaf)) (Node 8 Leaf Leaf)
-- ghci> leftMost tr
-- 7

leftMost :: Tree a -> a
leftMost (Node x Leaf _) = x
leftMost (Node x left right) = leftMost left



-- Complex Numbers
-- ==================

-- We have defined a datatype Complex, which represents complex numbers. We
-- will add some functions to work with complex numbers.

data Complex = Complex Double Double deriving (Show)

-- 're x' returns the real part of the complex number x.

re :: Complex -> Double
re (Complex r i) = r

-- 'im x' returns the imaginary part of the complex number x.

im :: Complex -> Double
im (Complex r i) = i

-- 'conjugate x' returns the complex conjugate of x.

conjugate :: Complex -> Complex
conjugate (Complex r i) = Complex r (-i)


-- Polynomials
-- ===========

-- We define a datatype Polynomial, which represents polynomials in one
-- variable over the field of rationals, with coefficients in increasing order.
-- We will add more functions to work with polynomials.

data Polynomial = Polynomial [Rational] deriving (Show)

-- Example: the polynomial x^1 + 0
p_x :: Polynomial
p_x = Polynomial [0, 1]


-- 'eval p x' evaluates the polynomial 'p' at point 'x'.
--
-- Example:
-- ghci> let p = Polynomial [2,0,-1]
-- ghci> eval p 2
-- -2

eval :: Polynomial -> Rational -> Rational
eval (Polynomial [c]) _ = c
eval (Polynomial (c:p)) x =  c + eval (Polynomial (map (x *) p)) x

-- 'derivative p' computes the first derivative of p.

derivative :: Polynomial -> Polynomial
derivative (Polynomial p) = Polynomial (tail [i*x | (i,x) <- zip [0..] p])

-- 'integral p' computes the indefinite integral of p.

integral :: Polynomial -> Polynomial
integral (Polynomial p) = Polynomial (0:[x / i | (i,x) <- zip [1..] p])
