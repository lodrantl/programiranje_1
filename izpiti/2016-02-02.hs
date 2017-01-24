-- 1. pisni izpit 2016

-- naloga 1

naloga1a :: [a -> a] -> a -> a

naloga1a [] x = x
naloga1a (f:fs) x = naloga1a fs (f x)

naloga1b :: (Ord a) => [a -> a] -> a -> a

naloga1b [] x = x
naloga1b (f:fs) x = naloga1b fs (max (f x) x)

naloga1c :: (Ord a) => [a -> a] -> a -> a

naloga1c [] x = x
naloga1c (f:fs) x = max (naloga1c fs (f x)) (naloga1c fs x)

-- naloga 3

data Drevo a = List a | Razvejano (Drevo a) (Drevo a) deriving (Show)

d = Razvejano (Razvejano (List 3) (Razvejano (List 1) (List 4))) (Razvejano (List 1) (List 5))

naloga3a :: Drevo a -> [a]

naloga3a (List a) = [a]
naloga3a (Razvejano l d) = naloga3a l ++ naloga3a d


naloga3b' :: Drevo a -> a -> Drevo a
naloga3b' (List _) x = List x
naloga3b' (Razvejano levo desno) x = Razvejano (naloga3b' levo x) (naloga3b' desno x)

naloga3max :: Ord a => Drevo a -> a
naloga3max (List x) = x
naloga3max (Razvejano levo desno) = max (naloga3max levo) (naloga3max desno)

naloga3b :: Ord a => Drevo a -> Drevo a
naloga3b d = naloga3b' d m
    where m = naloga3max d
