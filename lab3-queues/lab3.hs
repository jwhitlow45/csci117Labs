-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List (sort)
-- import Queue1
import Queue2
import Fraction

---------------- Part 1: Queue client

-- add a list of elements, in order, into a queue
adds :: [a] -> Queue a -> Queue a
adds [] q = q
adds (x:xs) q = adds xs (addq x q) 

-- *Main> a = addq 10 mtq
-- *Main> b = addq 9 a
-- *Main> c = addq 8 b
-- *Main> d = addq 7 c
-- *Main> e = addq 6 d
-- *Main> f = addq 5 e
-- *Main> g = addq 4 f
-- *Main> h = addq 3 g
-- *Main> adds [-10,-9,-8,-7] h
-- Queue1 [-7,-8,-9,-10,3,4,5,6,7,8,9,10]

-- remove all elements of the queue, putting them, in order, into a list
rems :: Queue a -> [a]
rems q
    | ismt q == True = []
    | otherwise = let (x,ys) = remq q in
        [x] ++ (id (rems ys))

-- *Main> a = addq 10 mtq
-- *Main> b = addq 9 a
-- *Main> c = addq 8 b
-- *Main> d = addq 7 c
-- *Main> e = addq 6 d
-- *Main> f = addq 5 e
-- *Main> g = addq 4 f
-- *Main> h = addq 3 g
-- *Main> rems h
-- [10,9,8,7,6,5,4,3]

-- test whether adding a given list of elements to an initially empty queue
-- and then removing them all produces the same list (FIFO). Should return True.
testq :: Eq a => [a] -> Bool
testq xs = xs == rems (adds xs mtq)

-- *Main> testq [10,9,8,7,6,5,4,3]
-- True

---------------- Part 2: Using typeclass instances for fractions

-- Construct a fraction, producing an error if it fails
fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
             Nothing -> error "Illegal fraction"
             Just fr -> fr


-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
average :: [Fraction] -> Fraction
average xs = (foldl (+) (fraction 0 1) xs) * (fraction 1 (toInteger (length xs)))

-- *Main> list1
-- [1/2,2/3,3/4,4/5,5/6,6/7,7/8,8/9,9/10,10/11,11/12,12/13,13/14,14/15,15/16,16/17,17/18,18/19,19/20,20/21]
-- *Main> list2
-- [1/1,1/2,1/3,1/4,1/5,1/6,1/7,1/8,1/9,1/10,1/11,1/12,1/13,1/14,1/15,1/16,1/17,1/18,1/19,1/20]
-- *Main> list3
-- [3/2,7/6,13/12,21/20,31/30,43/42,57/56,73/72,91/90,111/110,133/132,157/156,183/182,211/210,241/240,273/272,307/306,343/342,381/380,421/420]
-- *Main> average list1
-- 17955695/20692672
-- *Main> average list2
-- 11167027/62078016
-- *Main> average list3
-- 22/21
-- *Main> list4
-- [1/1,1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024,1/2048,1/4096,1/8192,1/16384,1/32768,1/65536,1/131072,1/262144,1/524288]
-- *Main> average list4
-- 209715/2097152
-- *Main> list5
-- [1/1,1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81,1/100,1/121,1/144,1/169,1/196,1/225,1/256,1/289,1/324,1/361,1/400]
-- *Main> average list5
-- 17299975731542641/216769503965414400
-- *Main> list6
-- [0/1,1/3,8/9,1/1,64/81,125/243,8/27,343/2187,512/6561,1/27,1000/59049,1331/177147,64/19683,2197/1594323,2744/4782969,125/531441,4096/43046721,4913/129140163,8/531441,6859/1162261467]
-- *Main> average list6
-- 239716211/1162261467
-- *Main> list7
-- [4/1,-4/3,4/5,-4/7,4/9,-4/11,4/13,-4/15,4/17,-4/19,4/21,-4/23,4/25,-4/27,4/29,-4/31,4/33,-4/35,4/37,-4/39]
-- *Main> average list7
-- 129049485078524/834833040166125


-- Some lists of fractions

list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]
list3 = zipWith (+) list1 list2

-- Make up several more lists for testing
list4 = [fraction 1 (2^n) | n <- [0..19]]
list5 = [fraction 1 (n^2) | n <- [1..20]]
list6 = [fraction (n^3) (3^n) | n <- [0..19]]
list7 = [fraction (4*(if mod n 4 == 2 then (-1) else 1)) (1+n) | n <- [0,2..1000]]

list8 = [list1, list2, list3, list4, list5, list6, list7]

-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago

-- *Main> map sort list8 -- performs sort on list1 through 7
-- [[1/2,2/3,3/4,4/5,5/6,6/7,7/8,8/9,9/10,10/11,11/12,12/13,13/14,14/15,15/16,16/17,17/18,18/19,19/20,20/21],
-- [1/2,1/3,1/4,1/5,1/6,1/7,1/8,1/9,1/10,1/11,1/12,1/13,1/14,1/15,1/16,1/17,1/18,1/19,1/20,1/1],
-- [3/2,7/6,13/12,21/20,31/30,43/42,57/56,73/72,91/90,111/110,133/132,157/156,183/182,211/210,241/240,273/272,307/306,343/342,381/380,421/420],
-- [1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024,1/2048,1/4096,1/8192,1/16384,1/32768,1/65536,1/131072,1/262144,1/524288,1/1],
-- [1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81,1/100,1/121,1/144,1/169,1/196,1/225,1/256,1/289,1/324,1/361,1/400,1/1],
-- [0/1,1/3,8/9,64/81,125/243,8/27,343/2187,512/6561,1/27,1000/59049,1331/177147,64/19683,2197/1594323,2744/4782969,125/531441,4096/43046721,4913/129140163,8/531441,6859/1162261467,1/1],
-- [-4/3,-4/7,-4/11,-4/15,-4/19,-4/23,-4/27,-4/31,-4/35,-4/39,4/5,4/9,4/13,4/17,4/21,4/25,4/29,4/33,4/37,4/1]]-- 

-- *Main> map sum list8 -- performs sum on list1 through 7
-- [89778475/5173168,
-- 55835135/15519504,
-- 440/21,
-- 1048575/524288,
-- 17299975731542641/10838475198270720,
-- 4794324220/1162261467,
-- 516197940314096/166966608033225]-- 

-- *Main> map product list8 -- performs product on list1 through 7
-- [1/21,
-- 1/2432902008176640000,
-- 128335079363657015232198361/55428820724455833600000000,
-- 1/1569275433846670190958947355801916604025588861116008628224,
-- 1/5919012181389927685417441689600000000,
-- 0/1,
-- 1099511627776/319830986772877770815625]-- 

-- *Main> map maximum list8 -- performs maximum on list1 through 7
-- [20/21,
-- 1/1,
-- 421/420,
-- 1/1,
-- 1/1,
-- 1/1,
-- 4/1]-- 

-- *Main> map minimum list8 -- performs minimum on list1 through 7
-- [1/2,
-- 1/2,
-- 3/2,
-- 1/2,
-- 1/4,
-- 0/1,
-- -4/3]-- 

-- *Main> map average list8 -- performs average on list1 through 7
-- [17955695/20692672,
-- 11167027/62078016,
-- 22/21,
-- 209715/2097152,
-- 17299975731542641/216769503965414400,
-- 239716211/1162261467,
-- 129049485078524/834833040166125]