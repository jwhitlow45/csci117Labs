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

*Main> left = (Node 12) (Empty) (Empty)
*Main> right = (Node 5) (Empty) (Empty)
*Main> myTree = (Node 3) (left) (right)
*Main> myTree 
Node 3 (Node 12 Empty Empty) (Node 5 Empty Empty)
*Main> a = insert_left 2 myTree 
*Main> a
Node 3 (Node 12 (Node 2 Empty Empty) Empty) (Node 5 Empty Empty)
*Main> b = insert_left 2 a 
*Main> b
Node 3 (Node 12 (Node 2 (Node 2 Empty Empty) Empty) Empty) (Node 5 Empty Empty)
*Main> 


---- Insert a new node in the rightmost spot in the tree
--insert_right :: a -> Tree a -> Tree a
--insert_right = undefined
--
---- Add up all the node values in a tree of numbers
--sum_nodes :: Num a => Tree a -> a
--sum_nodes = undefined
--
---- Produce a list of the node values in the tree via an inorder traversal
---- Feel free to use concatenation (++)
--inorder :: Tree a -> [a]
--inorder = undefined
