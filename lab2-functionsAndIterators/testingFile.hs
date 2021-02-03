-- 2. A backward list data structure 

-- Back Lists: Lists where elements are added to the back ("snoc" == rev "cons")
-- For example, the list [1,2,3] is represented as Snoc (Snoc (Snoc Nil 1) 2) 3
data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons = undefined

-- Convert a usual list into a BList (hint: use cons in the recursive case)
--toBList :: [a] -> BList a
--toBList = undefined
--
---- Add an element to the end of an ordinary list
--snoc :: [a] -> a -> [a]
--snoc = undefined
--
---- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
--fromBList :: BList a -> [a]
--fromBList = undefined