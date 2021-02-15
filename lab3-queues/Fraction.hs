module Fraction (Fraction, frac) where

-- Fraction type. ADT maintains the INVARIANT that every fraction Frac n m
-- satisfies m > 0 and gcd n m == 1. For fractions satisfying this invariant
-- equality is the same as literal equality (hence "deriving Eq")

data Fraction = Frac Integer Integer deriving (Eq)


-- Public constructor: take two integers, n and m, and construct a fraction
-- representing n/m that satisfies the invariant, if possible
frac :: Integer -> Integer -> Maybe Fraction
frac n m
    | m < 1 = Nothing
    | otherwise = let gcdnm = gcd n m in
        if gcdnm /= 1 then
            frac (div n gcdnm) (div m gcdnm) 
        else
            Just (Frac n m)

-- *Fraction> frac 1 0
-- Nothing
-- *Fraction> frac 0 0
-- Nothing
-- *Fraction> frac 0 2
-- Just (Frac 0 1)
-- *Fraction> frac 12 2
-- Just (Frac 6 1)
-- *Fraction> frac 12 6
-- Just (Frac 2 1)
-- *Fraction> frac 10 6
-- Just (Frac 5 3)
-- *Fraction> frac (-10) 6
-- Just (Frac (-5) 3)
-- *Fraction> frac (-10) (-6)
-- Nothing
-- *Fraction> frac (10) (-6)
-- Nothing

-- Show instance that outputs Frac n m as n/m
instance Show Fraction where
    show (Frac n m) = (show n) ++ "/" ++ (show m)

-- Ord instance for Fraction
instance Ord Fraction where
    compare (Frac n m) (Frac a b) = compare (div n m) (div a b)

-- *Main> (fraction 3 4) < (fraction 10 2)
-- True
-- *Main> (fraction 1200 4) < (fraction 10 2)
-- False
-- *Main> (fraction 1200 4) < (fraction 10 0)
-- *** Exception: Illegal fraction
-- CallStack (from HasCallStack):
--   error, called at lab3.hs:57:25 in main:Main
-- *Main> (fraction 120 4) < (fraction 10 3)
-- False

-- Num instance for Fraction
instance Num Fraction where
    negate (Frac n m)           = (Frac (n*(-1)) m)
    (+) (Frac n m) (Frac a b)   = let (num) = ((b*n)+(m*a))
                                      (den) = (b*m)
                                      (fgcd) = gcd num den
                                      (fnum) = div num fgcd
                                      (fden) = div den fgcd in
                                        (Frac fnum fden)
    (*) (Frac n m) (Frac a b)   = let (num) = (n*a)
                                      (den) = (m*b)
                                      (fgcd) = gcd num den
                                      (fnum) = div num fgcd
                                      (fden) = div den fgcd in
                                        (Frac fnum fden)
    fromInteger n               = (Frac n 1)
    abs (Frac n m)              = (Frac (abs n) m)
    signum (Frac n m)           = (Frac (signum n) m)

-- *Main> negate (fraction 10 2)
-- -5/1
-- *Main> negate (fraction 0 2)
-- 0/1
-- *Main> negate (fraction 90 13)
-- -90/13

-- *Main> (fraction 10 2) + (fraction 2 1)
-- 7/1
-- *Main> (fraction 10 2) + (fraction 2 5)
-- 27/5
-- *Main> (fraction 10 2) + (fraction (-2) 5)
-- 23/5
-- *Main> (fraction (-10) 2) + (fraction (-2) 5)
-- -27/5

-- *Main> (fraction 23 13) * (fraction 37 5)
-- 851/65
-- *Main> (fraction 20 13) * (fraction 32 5)
-- 128/13
-- *Main> (fraction 20 13) * (fraction (-32) 5)
-- -128/13
-- *Main> (fraction (-20) 13) * (fraction (-32) 5)
-- 128/13

-- *Main> fromInteger 10::Fraction
-- 10/1
-- *Main> fromInteger (-10)::Fraction
-- -10/1
-- *Main> fromInteger (-0)::Fraction
-- 0/1
-- *Main> fromInteger (0)::Fraction
-- 0/1
-- *Main> fromInteger (div 10 2)::Fraction
-- 5/1

-- *Main> abs (fraction 10 2)
-- 5/1
-- *Main> abs (fraction (-10) 2)
-- 5/1
-- *Main> abs (fraction (-(-(-10))) 2)
-- 5/1
-- *Main> abs (negate (fraction 10 2))
-- 5/1
-- *Main> abs (negate (fraction (-(-(-10))) 2) * (fraction (-10) 5))
-- 10/1
-- *Main> abs (fraction 0 2)
-- 0/1

-- *Main> signum (fraction 10 1)
-- 1/1
-- *Main> signum (fraction (-10) 1)
-- -1/1
-- *Main> signum (fraction (0) 1)
-- 0/1
-- *Main> signum (fraction (-120) 1)
-- -1/1
-- *Main> signum (fraction (-120) (121))
-- -1/1