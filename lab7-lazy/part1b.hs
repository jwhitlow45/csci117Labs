data Gen a = G (() -> (a, Gen a))

generate :: Int -> Gen Int
generate n = G (\_ -> (n, generate (n+1)))

gen_take :: Int -> Gen a -> [a]
gen_take 0 _ = []
gen_take n (G f) = let (x,g) = f () in x : gen_take (n-1) g

times :: Int -> Gen Int -> Gen Int
times n (G f) = let (x, g) = f() in G(\_->((n*x), times n g))

merge :: Ord a => Gen a -> Gen a -> Gen a
merge (G f) (G t) = let (a1, b1) = f ()
                        (a2, b2) = t ()
                        cmp = compare a1 a2 in
                            case cmp of EQ -> G(\_ -> (a1, merge b1 b2))
                                        GT -> G(\_ -> (a2, merge (G f) b2))
                                        LT -> G(\_ -> (a1, merge b1 (G t)))

hamming :: () -> Gen Int
hamming () = G(\_ -> (1, (merge (times 2 (hamming()))
                            (merge (times 3 (hamming()))
                                (times 5 (hamming ()))))))