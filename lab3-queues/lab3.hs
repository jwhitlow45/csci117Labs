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
average xs = undefined

-- Some lists of fractions

list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]
--list3 = zipWith (+) list1 list2

-- Make up several more lists for testing


-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago
