-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons a Nil = Snoc Nil a
cons a (Snoc c b) = Snoc (cons a c) b

-- Snoc (Snoc (Snoc Nil 3) 5) 3
-- *Main> const 3 cons 3 cons 9 cons 8
-- *Main> cons 3 (cons 4 (cons 5 (cons 9 Nil)))
-- Snoc (Snoc (Snoc (Snoc Nil 3) 4) 5) 9
-- *Main> cons 2 (cons 0 (cons 5 (cons 9 Nil)))
-- Snoc (Snoc (Snoc (Snoc Nil 2) 0) 5) 9

-- Convert a usual list into a BList (hint: use cons in the recursive case)
toBList :: [a] -> BList a
toBList [] = Nil
toBList (x:xs) = cons x (toBList (xs))

-- *Main> cons 3 (cons 4 (cons 5 (cons 9 Nil)))
-- Snoc (Snoc (Snoc (Snoc Nil 3) 4) 5) 9
-- *Main> cons 2 (cons 0 (cons 5 (cons 9 Nil)))
-- Snoc (Snoc (Snoc (Snoc Nil 2) 0) 5) 9
-- *Main> toBList [1,2,3,4,5]
-- Snoc (Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4) 5
-- *Main> toBList [9,2,10,4,4]
-- Snoc (Snoc (Snoc (Snoc (Snoc Nil 9) 2) 10) 4) 4
-- *Main> toBList [9,25,10,4,202]
-- Snoc (Snoc (Snoc (Snoc (Snoc Nil 9) 25) 10) 4) 202
-- *Main> toBList "teststring"
-- Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 't') 'e') 's') 't') 's') 't') 'r') 'i') 'n') 'g'

-- Add an element to the end of an ordinary list
snoc :: [a] -> a -> [a]
snoc [] a = [a]
snoc (x:xs) a = x:(snoc xs a)

-- *Main> snoc "helpme" 'p'
-- "helpmep"
-- *Main> snoc [1,2,3,4,5] 10
-- [1,2,3,4,5,10]
-- *Main> snoc [1,2,19,4,5,10] 10
-- [1,2,19,4,5,10,10]


-- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
fromBList :: BList a -> [a]
fromBList Nil = []
fromBList (Snoc a b) = snoc (fromBList a) b

-- *Main> list = toBList [1,2,3,4,5,6,7]
-- *Main> list
-- Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4) 5) 6) 7
-- *Main> fromBList list
-- [1,2,3,4,5,6,7]
-- *Main> list = toBList "i don't know what a snoc is"
-- *Main> fromBList li
-- *Main> fromBList list
-- "i don't know what a snoc is"