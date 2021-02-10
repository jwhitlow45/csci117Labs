module Queue2 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error "Can't remove an element
                                 --   from an empty queue" on empty

--- Implementation -----------

{- In this implementation, a queue is represented as a pair of lists.
The "front" of the queue is at the head of the first list, and the
"back" of the queue is at the HEAD of the second list.  When the
second list is empty and we want to remove an element, we REVERSE the
elements in the first list and move them to the back, leaving the
first list empty. We can now process the removal request in the usual way.
-}

data Queue a = Queue2 [a] [a] deriving (Show) -- added deriving (Show) for debugging purposes

-- define an empty queue
mtq = Queue2 [] []
-- *Main> mtq
-- Queue2 [] []

-- check if a queue is empty
ismt (Queue2 xs ys)
    | length xs == 0 && length ys == 0 = True
    | otherwise = False

-- *Main> ismt mtq
-- True
-- *Main> a = addq 10 mtq
-- *Main> b = addq 9 a
-- *Main> c = addq 8 b
-- *Main> d = addq 7 c
-- *Main> e = addq 6 d
-- *Main> f = addq 5 e
-- *Main> g = addq 4 f
-- *Main> h = addq 3 g
-- *Main> ismt h
-- False

-- adds an element to the back of the queue
addq x (Queue2 xs ys) = (Queue2 (x:xs) ys)

-- *Main> a = addq 10 mtq
-- *Main> b = addq 9 a
-- *Main> c = addq 8 b
-- *Main> d = addq 7 c
-- *Main> e = addq 6 d
-- *Main> f = addq 5 e
-- *Main> g = addq 4 f
-- *Main> h = addq 3 g
-- *Main> h
-- Queue2 [3,4,5,6,7,8,9,10] []

-- removes an element from the front of the queue
remq (Queue2 xs ys)
    | ismt (Queue2 xs ys) == True = error "Cannot remove from and empty queue"
    | length ys == 0 = remq (Queue2 [] (reverse xs++ys)) 
    | otherwise = (last ys, Queue2 xs (init ys))

-- *Main> a = addq 10 mtq
-- *Main> b = addq 9 a
-- *Main> c = addq 8 b
-- *Main> d = addq 7 c
-- *Main> e = addq 6 d
-- *Main> f = addq 5 e
-- *Main> g = addq 4 f
-- *Main> h = addq 3 g
-- *Main> i = addq 11 h
-- *Main> j = addq 12 h
-- *Main> j
-- Queue2 [12,3,4,5,6,7,8,9,10] []
-- *Main> i = snd (remq h)
-- *Main> i
-- Queue2 [] [10,9,8,7,6,5,4]
-- *Main> addq 11 i
-- Queue2 [11] [10,9,8,7,6,5,4]
-- *Main> j = addq 11 i
-- *Main> k = addq 12 j
-- *Main> k
-- Queue2 [12,11] [10,9,8,7,6,5,4]
-- *Main> remq k
-- (4,Queue2 [12,11] [10,9,8,7,6,5])
-- *Main> l = remq k
-- *Main> l
-- (4,Queue2 [12,11] [10,9,8,7,6,5])
-- *Main> l = snd (remq k)
-- *Main> m = snd (remq l)
-- *Main> n = snd (remq m)
-- *Main> m
-- Queue2 [12,11] [10,9,8,7,6]
-- *Main> m = mtq
-- *Main> addq 11 m
-- Queue2 [11] []
-- *Main> n = addq 11 m
-- *Main> o = addq 12 n
-- *Main> o
-- Queue2 [12,11] []
-- *Main> remq o
-- (12,Queue2 [] [11])