---- Part 3: Higher-order functions ----------------

-- The functions map, all, any, filter, dropWhile, takeWhile, and break
-- from the Prelude are all higher-order functions. Reimplement them here
-- as list recursions. break should process each element of the list at
-- most once. All functions should produce the same output as the originals.

my_map :: (a -> b) -> [a] -> [b]
my_map f [] = []
my_map f (x:xs) = (f x):(my_map f xs)

-- *Main> my_map (12==) [1,2,3,4]
-- [False,False,False,False]
-- *Main> map (12==) [1,2,3,4]
-- [False,False,False,False]
-- *Main> my_map (<10) [1,12,2,10,2]
-- [True,False,True,False,True]
-- *Main> map (<10) [1,12,2,10,2]
-- [True,False,True,False,True]
-- *Main> map (<'g') "snoc is still very confusing"
-- [False,False,False,True,True,False,False,True,False,False,False,False,False,True,False,True,False,False,True,True,False,False,True,False,False,False,False,False]


my_all :: (a -> Bool) -> [a] -> Bool
my_all f [] = True
my_all f (x:xs)
    | f x /= True = False
    | otherwise = my_all f xs

-- *Main> my_all (1==) [1,2,3]
-- False
-- *Main> my_all (1==) [1,1]
-- True
-- *Main> my_all (1==) [1,1,1,1,1,1]
-- True
-- *Main> my_all (1==) [1,1,1,3,1,1]
-- False
-- *Main> my_all (1==) [3,1,1,1,1,3]
-- False

my_any :: (a -> Bool) -> [a] -> Bool
my_any f [] = False
my_any f (x:xs)
    |f x == True = True
    |otherwise = my_any f xs 

-- *Main> my_any (1==) [1,2,3,4]
-- True
-- *Main> my_any (1==) [3,2,3,4]
-- False
-- *Main> my_any (1==) [3,2,3,1]
-- True
-- *Main> my_any (1==) [3,2,1,1]
-- True
-- *Main> my_any (1==) [1,1]
-- True
-- *Main> my_any ('p'==) "please let me figure out iterative inorder"
-- True
-- *Main> my_any (10<) [1,2,3,4,5,6]
-- False

my_filter :: (a -> Bool) -> [a] -> [a]
my_filter f [] = []
my_filter f (x:xs)
    | f x == True = x:(my_filter f xs)
    | otherwise = my_filter f xs

-- *Main> my_filter (1==) [2,3,1,4,5,1]
-- [1,1]
-- *Main> my_filter (1==) [1,2,3,1,4,5,1]
-- [1,1,1]
-- *Main> my_filter (1==) [1,2,3,1,4,5]
-- [1,1]
-- *Main> my_filter (1==) [1,2,3,4,5]
-- [1]
-- *Main> my_filter (1==) [1,2,3,4,5,1]
-- [1,1]
-- *Main> my_filter (<3) [1,2,3,4,5,1]
-- [1,2,1]
-- *Main> my_filter (<3) [1,2,3,4,5]
-- [1,2]
-- *Main> my_filter ('a'==) "im starting to get this now"
-- "a"
-- *Main> my_filter ('a'==) "im starting to get this now a lot better than before"
-- "aaa"
-- *Main> my_filter ('a'==) "im st"
-- ""

my_dropWhile :: (a -> Bool) -> [a] -> [a]
my_dropWhile f [] = []
my_dropWhile f (x:xs)
    | f x == True = my_dropWhile f xs
    | otherwise = x:xs

-- *Main> my_dropWhile (1==) [1,2,3,4]
-- [2,3,4]
-- *Main> my_dropWhile (1==) [1,1,2,3,4]
-- [2,3,4]
-- *Main> my_dropWhile (1==) [1,1,2,1,3,4]
-- [2,1,3,4]
-- *Main> my_dropWhile (1==) [1,1,2,1,3,4,1]
-- [2,1,3,4,1]
-- *Main> my_dropWhile ('a'==) "aaaaaaaaaple"
-- "ple"

my_takeWhile :: (a -> Bool) -> [a] -> [a]
my_takeWhile f [] = []
my_takeWhile f (x:xs)
    | f x == True = x:(my_takeWhile f xs)
    | otherwise = []

-- *Main> my_takeWhile (1==) [1,1,1]
-- [1,1,1]
-- *Main> my_takeWhile (1==) [1,1,1,2]
-- [1,1,1]
-- *Main> my_takeWhile (1==) [1,1,1,2,1]
-- [1,1,1]
-- *Main> my_takeWhile ('a'==) "aaaaaaaapple"
-- "aaaaaaaa"

my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break f [] = ([], [])
my_break f (x:xs)
    | f x == False = let ys = (my_break f xs)
        in (x:(fst ys),(snd ys))
    | otherwise = ([], x:xs)

-- *Main> my_break (1==) [1,2,3,4]
-- ([],[1,2,3,4])
-- *Main> my_break (1==) [0,0,0,0,1,2,3,4]
-- ([0,0,0,0],[1,2,3,4])
-- *Main> my_break (1==) [0,0,0,0,1,2,3,4,1]
-- ([0,0,0,0],[1,2,3,4,1])
-- *Main> my_break ('a'==) "the quick bron fox jumped over the lazy dog"
-- ("the quick bron fox jumped over the l","azy dog")
-- *Main> my_break (1==) [2,3,4,1,5,6]
-- ([2,3,4],[1,5,6])


-- Implement the Prelude functions and, or, concat using foldr
my_and :: [Bool] -> Bool
my_and xs = foldr (&&) True xs


-- *Main> my_and [True]
-- True
-- *Main> my_and [True,False]
-- False
-- *Main> my_and [False,True,False]
-- False
-- *Main> my_and [True,False,True]
-- False
-- *Main> my_and [True,True,True,True]
-- True

my_or :: [Bool] -> Bool
my_or xs = foldr (||) False xs

-- *Main> my_or [False,True,False]
-- True
-- *Main> my_or [False,True,True]
-- True
-- *Main> my_or [True,True,True]
-- True
-- *Main> my_or [False,False,False]
-- False
-- *Main> my_or [True,False,False,False]
-- True
-- *Main> my_or [False,False,False,True]
-- True

my_concat :: [[a]] -> [a]
my_concat xs = foldr (++) [] xs

-- *Main> my_concat ["we are going", " to add some strings", " together now"]
-- "we are going to add some strings together now"
-- *Main> my_concat [[1,2,3],[4,5,6],[7,8,9]]
-- [1,2,3,4,5,6,7,8,9]
-- *Main> my_concat [[],[1,2,3]]
-- [1,2,3]

-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum [] = 0
my_sum xs = foldl (+) 0 xs

-- *Main> my_sum [1,2,3]
-- 6
-- *Main> my_sum [1,2,3,10]
-- 16
-- *Main> my_sum [12,2,3,10]
-- 27
-- *Main> my_sum [12,2,3,-10]
-- 7
-- *Main> my_sum [-12,2,3,-10]
-- -17

my_product :: Num a => [a] -> a
my_product [] = 1
my_product xs = foldl (*) 1 xs

-- *Main> my_product [1,2,3]
-- 6
-- *Main> my_product [1,2,3,7]
-- 42
-- *Main> my_product [1,2,3,-7]
-- -42
-- *Main> my_product [1,2,-3,-7]
-- 42
-- *Main> my_product [1,2,-3,-7,20]
-- 840
-- *Main> my_product [-3,-7,20]
-- 420

my_reverse :: [a] -> [a]
my_reverse xs = foldl (\stack x -> x:stack) [] xs

-- [3,2,1]
-- *Main> my_reverse [1,2,3,2,1]
-- [1,2,3,2,1]
-- *Main> my_reverse [1,2,3,2,2]
-- [2,2,3,2,1]
-- *Main> my_reverse []
-- []
-- *Main> my_reverse [1,2,1,2]
-- [2,1,2,1]
-- *Main> my_reverse "this is a string"
-- "gnirts a si siht"