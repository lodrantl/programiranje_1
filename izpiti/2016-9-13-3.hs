vrednost :: Fractional t => [(Int, t)] -> t -> t

vrednost [] _ = 0
vrednost ((eks, koef):ostali) x = koef * x^eks + (vrednost ostali x)

vsota :: Eq t => Fractional t => [(Int, t)] -> [(Int, t)] -> [(Int, t)]
vsota d [] = d
vsota [] d = d
vsota s1@((e1, k1):o1) s2@((e2, k2):o2) | (e1 == e2) && (k1 == (negate k2)) = vsota o1 o2
                                        | e1 == e2 = (e1, k1+k2):(vsota o1 o2)
                                        | e1 < e2 = (e1, k1):(vsota o1 s2)
                                        | e1 > e2 = (e2, k2):(vsota s1 o2)


produkt :: Eq t => Fractional t => [(Int, t)] -> [(Int, t)] -> [(Int, t)]
produkt [] _ = []
produkt _ [] = []
produkt s1@([(e1, k1)]) ((e2, k2):o2) = (e1+e2, k1*k2):(produkt s1 o2)
produkt (p1:o1) s2 = vsota (produkt [p1] s2) (produkt o1 s2)

koeficienti :: Eq t => Fractional t => [(Int, t)] -> [t]
koeficienti p = koeficienti_t p 0 where
  koeficienti_t [] _ = []
  koeficienti_t ((e, k):o) x | e == x = k:(koeficienti_t o (x+1))
                             | True = 0:(koeficienti_t ((e, k):o) (x+1))
