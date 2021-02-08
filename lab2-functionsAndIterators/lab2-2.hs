-- CSci 117, Lab 2:  Functional techniques, iterators/accumulators,
-- and higher-order functions. Make sure you test all of your functions,
-- including key tests and their output in comments after your code.


-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
-- and          deal   [2,3,4,5,6,7] = ([2,4,6], [3,5,7])
-- Hint: notice what's happening between the answers to deal [2..7] and
-- deal (1:[2..7]) above to get an idea of how to approach the recursion
deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal (x:xs) = let (ys,zs) = deal xs
              in (x:zs,ys)          --place x into zs, then ys,
                                    --alternating until the list is empty

-- *Main> deal [1,2,3,4,5,6,7]
-- ([1,3,5,7],[2,4,6])
-- *Main> deal [1,2,3,4,5,6]
-- ([1,3,5],[2,4,6])
-- *Main> deal [1,2,6,4,42,10]
-- ([1,6,42],[2,4,10])


-- Now implement merge and mergesort (ms), and test with some
-- scrambled lists to gain confidence that your code is correct
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys                    --append rest of ys onto end of list
merge xs [] = xs                    --append rest of xs only end of list
merge (x:xs) (y:ys)
  | x <= y = x:(merge (xs) (y:ys))  --place 'sorted' x in front of list
  | x > y  = y:(merge (x:xs) (ys))  --place 'sorted' y in front of list

-- *Main> merge [1,2,5,6,41] [0,1,5,9,76]
-- [0,1,1,2,5,5,6,9,41,76]
-- *Main> merge [2,5,10,47] [0,9,76]
-- [0,2,5,9,10,47,76]
-- *Main> merge [2,5,10,47] [-10,0,9,76,100]
-- [-10,0,2,5,9,10,47,76,100]

ms :: Ord a => [a] -> [a]
ms [] = []
ms [x] = [x]
ms xs = let (ys, zs) = deal xs
        in merge (ms ys) (ms zs) -- general case: deal, recursive call, merge

-- *Main> ms [1,19,0,120,123,124080,124,-123,1678,4034,0]
-- [-123,0,0,1,19,120,123,124,1678,4034,124080]
-- *Main> ms [19,0,-120,2123,120,124,-123,168,34,0,10]
-- [-123,-120,0,0,10,19,34,120,124,168,2123]
-- *Main> ms [10,9,8,7,6,5,4,3,2,1]
-- [1,2,3,4,5,6,7,8,9,10]

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

-- 3. A binary tree data structure
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties Empty = 1
num_empties (Node root l r) = (num_empties l) + (num_empties r)


-- *Main> myTree = (Node 12) (Empty) (Empty)
-- *Main> num_empties myTree 
-- 2
-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> right = (Node 1) (5) (Empty)
-- *Main> right = (Node 1) (Empty) (Empty)
-- *Main> myTree = (Node 3) (left) (right)
-- *Main> num_empties myTree 
-- 4

-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes Empty = 0
num_nodes (Node root l r) = (num_nodes l) + (num_nodes r) + 1

-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> right = (Node 5) (Empty) (Empty)
-- *Main> myTree = (Node 3) (left) (right)
-- *Main> num_nodes myTree 
-- 3
-- *Main> other = (Node 3) (Empty) (Empty)
-- *Main> left = (Node 12) (other) (Empty)
-- *Main> myTree = (Node 3) (left) (right)
-- *Main> num_nodes myTree 
-- 4

---- Insert a new node in the leftmost spot in the tree
insert_left :: a -> Tree a -> Tree a
insert_left newNode Empty = (Node newNode Empty Empty)
insert_left newNode (Node root l r) = Node root (insert_left newNode l) r

-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> right = (Node 5) (Empty) (Empty)
-- *Main> myTree = (Node 3) (left) (right)
-- *Main> myTree 
-- Node 3 (Node 12 Empty Empty) (Node 5 Empty Empty)
-- *Main> a = insert_left 2 myTree 
-- *Main> a
-- Node 3 (Node 12 (Node 2 Empty Empty) Empty) (Node 5 Empty Empty)
-- *Main> b = insert_left 2 a 
-- *Main> b
-- Node 3 (Node 12 (Node 2 (Node 2 Empty Empty) Empty) Empty) (Node 5 Empty Empty)
-- *Main> 


-- Insert a new node in the rightmost spot in the tree
insert_right :: a -> Tree a -> Tree a
insert_right newNode Empty = (Node newNode Empty Empty)
insert_right newNode (Node root l r) = Node root l (insert_right newNode r) 

-- *Main> myTree 
-- Node 3 (Node 12 Empty Empty) (Node 5 Empty Empty)
-- *Main> a = insert_right 2 myTree 
-- *Main> a
-- Node 3 (Node 12 Empty Empty) (Node 5 Empty (Node 2 Empty Empty))
-- *Main> b = insert_right 2 a
-- *Main> b
-- Node 3 (Node 12 Empty Empty) (Node 5 Empty (Node 2 Empty (Node 2 Empty Empty)))
-- *Main> 

-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes Empty = 0
sum_nodes (Node root l r) = (sum_nodes l) + (sum_nodes r) + root

-- left = (Node 7) (other) (Empty)
-- right = (Node 5) (Empty) (Empty)
-- myTree = (Node 8) (left) (right)
-- *Main> sum_nodes myTree 
-- 20
-- left = (Node 2) (other) (Empty)
-- right = (Node 5) (Empty) (Empty)
-- myTree = (Node 8) (left) (right)
-- *Main> sum_nodes myTree 
-- 15
-- other = (Node 3) (Empty) (Empty)
-- left = (Node 2) (other) (Empty)
-- *Main> sum_nodes myTree 
-- 18

---- Produce a list of the node values in the tree via an inorder traversal
---- Feel free to use concatenation (++)
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node root l r) = (inorder l) ++ [root] ++ (inorder r)

-- other = (Node 3) (Empty) (Empty)
-- left = (Node 2) (other) (Empty)
-- right = (Node 5) (Empty) (Empty)
-- myTree = (Node 8) (left) (right)
-- *Main> inorder myTree 
-- [3,2,8,5]
-- other = (Node "test") (Empty) (Empty)
-- left = (Node "test1") (other) (Empty)
-- right = (Node"test2") (Empty) (Empty)
-- myTree = (Node "test3") (left) (right)
-- *Main> inorder myTree 
-- ["test","test1","test3","test2"]

-- 4. A different, leaf-based tree data structure
data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)
num_elts :: Tree2 a -> Int
num_elts (Leaf a) = 1
num_elts (Node2 root l r) = (num_elts l) + (num_elts r) + 1

-- left = (Node2 12) (Leaf 4) (Leaf 8)
-- other = (Node2 1) (Leaf 6) (Leaf 10)
-- right = (Node2 2) other (Leaf 9)
-- root = (Node2 3) left right
-- *Main> num_elts root
-- 9
-- left = (Node2 12) (Leaf 4) (Leaf 8)
-- other = (Node2 1) (Leaf 6) (Leaf 10)
-- right = (Node2 2) other left
-- root = (Node2 3) left right
-- *Main> num_elts root
-- 11

-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf a) = a
sum_nodes2 (Node2 root l r) = (sum_nodes2 l) + (sum_nodes2 r) + root

-- left = (Node2 12) (Leaf 4) (Leaf 8)
-- other = (Node2 1) (Leaf 6) (Leaf 10)
-- right = (Node2 2) other (Leaf 9)
-- root = (Node2 3) left right
-- *Main> sum_nodes2 root
-- 55
-- left = (Node2 12) (Leaf 4) (Leaf 8)
-- other = (Node2 1) (Leaf 6) (Leaf 10)
-- right = (Node2 2) other left
-- root = (Node2 3) left right
-- *Main> sum_nodes2 root
-- 70


-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: Tree2 a -> [a]
inorder2 (Leaf a) = [a]
inorder2 (Node2 root l r) = (inorder2 l) ++ [root] ++ (inorder2 r)

-- left = (Node2 12) (Leaf 4) (Leaf 8)
-- other = (Node2 1) (Leaf 6) (Leaf 10)
-- right = (Node2 2) other (Leaf 9)
-- root = (Node2 3) left right
-- *Main> inorder2 root
-- [4,12,8,3,6,1,10,2,9]
-- left = (Node2 12) (Leaf 4) (Leaf 8)
-- other = (Node2 1) (Leaf 6) (Leaf 10)
-- right = (Node2 2) other left
-- root = (Node2 3) left right
-- *Main> inorder2 root
-- [4,12,8,3,6,1,10,2,4,12,8]

-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
conv21 :: Tree2 a -> Tree a
conv21 (Leaf a) = (Node a) Empty Empty
conv21 (Node2 root l r) = Node (id root) (conv21 l) (conv21 r)

-- left = (Node2 12) (Leaf 4) (Leaf 8)
-- other = (Node2 1) (Leaf 6) (Leaf 10)
-- right = (Node2 2) other (Leaf 9)
-- root = (Node2 3) left right
-- *Main> conv21 root
-- Node 3 (Node 12 (Node 4 Empty Empty) (Node 8 Empty Empty)) (Node 2 (Node 1 (Node 6 Empty Empty) (Node 10 Empty Empty)) (Node 9 Empty Empty))
-- *Main> root
-- Node2 3 (Node2 12 (Leaf 4) (Leaf 8)) (Node2 2 (Node2 1 (Leaf 6) (Leaf 10)) (Leaf 9))
-- left = (Node2 12) (Leaf 4) (Leaf 8)
-- other = (Node2 1) (Leaf 6) (Leaf 10)
-- right = (Node2 2) other left
-- root = (Node2 3) left right
-- *Main> conv21 root
-- Node 3 (Node 12 (Node 4 Empty Empty) (Node 8 Empty Empty)) (Node 2 (Node 1 (Node 6 Empty Empty) (Node 10 Empty Empty)) (Node 12 (Node 4 Empty Empty) (Node 8 Empty Empty)))
-- *Main> root
-- Node2 3 (Node2 12 (Leaf 4) (Leaf 8)) (Node2 2 (Node2 1 (Leaf 6) (Leaf 10)) (Node2 12 (Leaf 4) (Leaf 8)))


---- Part 2: Iteration and Accumulators ----------------

-- Both toBList and fromBList from Part 1 Problem 2 are O(n^2) operations.
-- Reimplement them using iterative helper functions (locally defined using
-- a 'where' clause) with accumulators to make them O(n)
-- data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
-- cons :: a -> BList a -> BList a
-- cons a Nil = Snoc Nil a
-- cons a (Snoc c b) = Snoc (cons a c) b-- 

-- snoc :: [a] -> a -> [a]
-- snoc [] a = [a]
-- snoc (x:xs) a = x:(snoc xs a)

toBList' :: [a] -> BList a
toBList' a = toBListHelper a where 
    toBListHelper :: [a] -> BList a
    toBListHelper [] = Nil
    toBListHelper (x:xs) = cons x (toBListHelper xs)

-- *Main> toBList' [1,2,3,4]
-- Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4
-- *Main> toBList' "i still don't know what a snoc is"
-- Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 'i') ' ') 's') 't') 'i') 'l') 'l') ' ') 'd') 'o') 'n') '\'') 't') ' ') 'k') 'n') 'o') 'w') ' ') 'w') 'h') 'a') 't') ' ') 'a') ' ') 's') 'n') 'o') 'c') ' ') 'i') 's'
-- *Main> toBList' "no entiendo"
-- Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 'n') 'o') ' ') 'e') 'n') 't') 'i') 'e') 'n') 'd') 'o'
-- *Main> toBList' [198,102,248,245,232,293]
-- Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 198) 102) 248) 245) 232) 293

fromBList' :: BList a -> [a]
fromBList' a = fromBListHelper a where
    fromBListHelper :: BList a -> [a]
    fromBListHelper Nil = []
    fromBListHelper (Snoc a b) = snoc (fromBListHelper a) b

-- *Main> toBList' "i cant read"
-- Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc (Snoc Nil 'i') ' ') 'c') 'a') 'n') 't') ' ') 'r') 'e') 'a') 'd'
-- *Main> test = toBList' "i cant read"
-- *Main> fromBList' test
-- "i cant read"
-- *Main> test = toBList' [123,456,789]
-- *Main> fromBList' test
-- [123,456,789]
-- *Main> test
-- Snoc (Snoc (Snoc Nil 123) 456) 789


-- Even tree functions that do multiple recursive calls can be rewritten
-- iteratively using lists of trees and an accumulator. For example,
sum_nodes' :: Num a => Tree a -> a
sum_nodes' t = sum_nodes_it [t] 0 where
    sum_nodes_it :: Num a => [Tree a] -> a -> a
    sum_nodes_it [] a = a
    sum_nodes_it (Empty:ts) a = sum_nodes_it ts a
    sum_nodes_it (Node n t1 t2:ts) a = sum_nodes_it (t1:t2:ts) (n+a)

-- Use the same technique to convert num_empties, num_nodes, and sum_nodes2
-- into iterative functions with accumulators

num_empties' :: Tree a -> Int
num_empties' t = num_empties_helper [t] 0 where
    num_empties_helper :: [Tree a] -> Int -> Int
    num_empties_helper [] n = n
    num_empties_helper (Empty:ts) n = num_empties_helper ts (n+1)
    num_empties_helper (Node root l r:ts) n = num_empties_helper (l:r:ts) n

-- left = (Node 12) (Empty) (Empty)
-- other = (Node 1) (Empty) (Empty)
-- right = (Node 2) other left
-- root = (Node 3) left right
-- *Main> num_empties' root
-- 6
-- left = (Node 12) (Empty) (Empty)
-- other = (Node 1) (Empty) (Empty)
-- right = (Node 2) other (Empty)
-- root = (Node 3) left right
-- *Main> num_empties' root
-- 5
-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> other = (Node 1) (Empty) (Empty)
-- *Main> right = (Node 2) other (Empty)
-- *Main> root = (Node 3) left right
-- *Main>
-- *Main> num_empties' root
-- 5
-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> other = (Node 1) (Empty) (Empty)
-- *Main> right = (Node 2) other (Node 3 Empty (Node 2 Empty Empty))
-- *Main> root = (Node 3) left right
-- *Main> num_empties' root
-- 7

num_nodes' :: Tree a -> Int
num_nodes' t = num_nodes_helper [t] 0 where
    num_nodes_helper :: [Tree a] -> Int -> Int
    num_nodes_helper [] n = n
    num_nodes_helper (Empty:ts) n = num_nodes_helper ts n
    num_nodes_helper (Node root l r:ts) n = num_nodes_helper (l:r:ts) (n+1)

-- left = (Node 12) (Empty) (Empty)
-- other = (Node 1) (Empty) (Empty)
-- right = (Node 2) other (Empty)
-- root = (Node 3) left right
-- *Main> num_nodes' root
-- 4
-- left = (Node 12) (Empty) (Empty)
-- other = (Node 1) (Empty) (Empty)
-- right = (Node 2) other left
-- root = (Node 3) left right
-- *Main> num_nodes' root
-- 5
-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> other = (Node 1) (Empty) (Empty)
-- *Main> right = (Node 2) other (Node 3 Empty (Node 2 Empty Empty))
-- *Main> root = (Node 3) left right
-- *Main> num_nodes' root
-- 6
-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> other = (Node 1) (Empty) (Empty)
-- *Main> right = (Node 2) other (Node 3 Empty (Node 2 (Node 2 Empty Empty) Empty))
-- *Main> root = (Node 3) left right
-- *Main> num_nodes' root
-- 7
-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> right = (Node 2) Empty (Node 3 Empty (Node 2 (Node 2 Empty Empty) Empty))
-- *Main> root = (Node 3) left right
-- *Main> num_nodes' root
-- 6
-- *Main> left = (Node 12) (Empty) (Empty)
-- *Main> right = (Node 2) Empty (Node 3 Empty (Node 2 (Empty) Empty))
-- *Main> root = (Node 3) left right
-- *Main> num_nodes' root
-- 5

sum_nodes2' :: Num a => Tree2 a -> a
sum_nodes2' t = sum_nodes_helper [t] 0 where
    sum_nodes_helper :: Num a => [Tree2 a] -> a -> a
    sum_nodes_helper [] n = n
    sum_nodes_helper (Leaf root:ts) n = sum_nodes_helper ts (n+root)
    sum_nodes_helper (Node2 root l r:ts) n = sum_nodes_helper (l:r:ts) (n+root)

-- left = (Node 12) (Empty) (Empty)
-- other = (Node 1) (Empty) (Empty)
-- right = (Node 2) other left
-- root = (Node 3) left right
-- *Main> sum_nodes2' root
-- 47
-- left = (Node2 12) (Leaf 9) (Leaf 8)
-- other = (Node2 1) (Leaf 10) (Leaf 2)
-- right = (Node2 2) other left
-- root = (Node2 3) left right
-- *Main> sum_nodes2' root
-- 76

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.
inorder2' :: Tree2 a -> [a]
inorder2' xs = inorder_helper [xs] [] where
               inorder_helper [] ys = ys
               inorder_helper ((Leaf l):xs) ys = inorder_helper xs (l:ys)
               inorder_helper ((Node2 l a b):xs) ys = inorder_helper (b:(Leaf l):a:xs) (ys)

-- *Main> left = (Node2 12) (Leaf 9) (Leaf 8)
-- *Main> other = (Node2 1) (Leaf 10) (Leaf 2)
-- *Main> right = (Node2 2) other left
-- *Main> root = (Node2 3) left right
-- *Main> inorder2
-- inorder2   inorder2'
-- *Main> inorder2' root
-- [9,12,8,3,10,1,2,2,9,12,8]
-- *Main> left = (Node2 12) (Leaf 9) (Leaf 8)
-- *Main> other = (Node2 1) (Leaf 10) (Leaf 2)
-- *Main> right = (Node2 2) other (Leaf 20)
-- *Main> root = (Node2 3) left right
-- *Main> inorder2' root
-- [9,12,8,3,10,1,2,2,20]

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



---- Part 4: Extra Credit ----------------

-- Convert a Tree into an equivalent Tree2, IF POSSIBLE. That is, given t1,
-- return t2 such that conv21 t2 = t1, if it exists. (In math, this is called
-- the "inverse image" of the function conv21.)  Thus, if conv21 t2 = t1, then
-- it should be that conv 12 t1 = Just t2. If there does not exist such a t2,
-- then conv12 t1 = Nothing. Do some examples on paper first so you can get a
-- sense of when this conversion is possible.
conv12 :: Tree a -> Maybe (Tree2 a)
conv12 = undefined


-- Binary Search Trees. Determine, by making only ONE PASS through a tree,
-- whether or not it's a Binary Search Tree, which means that for every
-- Node a t1 t2 in the tree, every element in t1 is strictly less than a and
-- every element in t2 is strictly greater than a. Complete this for both
-- Tree a and Tree2 a.

-- Hint: use a helper function that keeps track of the range of allowable
-- element values as you descend through the tree. For this, use the following
-- extended integers, which add negative and positvie infintiies to Int:

data ExtInt = NegInf | Fin Int | PosInf deriving Eq

instance Show ExtInt where
  show NegInf     = "-oo"
  show (Fin n) = show n
  show PosInf     = "+oo"

instance Ord ExtInt where
  compare NegInf  NegInf  = EQ
  compare NegInf  _       = LT
  compare (Fin n) (Fin m) = compare n m
  compare (Fin n) PosInf  = LT
  compare PosInf  PosInf  = EQ
  compare _       _       = GT
  -- Note: defining compare automatically defines <, <=, >, >=, ==, /=

bst :: Tree Int -> Bool
bst = undefined
    
bst2 :: Tree2 Int -> Bool
bst2 = undefined
