module Queue1 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error "Can't remove an element
                                 --   from an empty queue" on empty

---- Implementation -----------

{- In this implementation, a queue is represented as an ordinary list.
The "front" of the queue is at the head of the list, and the "back" of
the queue is at the end of the list.
-}

data Queue a = Queue1 [a] deriving (Show) -- added deriving (Show) for debugging purposes

-- defines an empty queue
mtq = Queue1 []
-- *Main> mtq
-- Queue1 []


-- check if queue is empty
ismt (Queue1 xs)
    | length xs == 0 = True
    | otherwise = False

-- *Main> ismt mtq
-- True
-- *Main> ismt (addq 10 mtq)
-- False


-- add an element to the queue
addq x (Queue1 xs) = Queue1 (x:xs)

-- *Main> a = addq 10 mtq
-- *Main> b = addq 9 a
-- *Main> c = addq 8 b
-- *Main> d = addq 7 c
-- *Main> e = addq 6 d
-- *Main> f = addq 5 e
-- *Main> g = addq 4 f
-- *Main> h = addq 3 g
-- *Main> h
-- Queue1 [3,4,5,6,7,8,9,10]

-- removes element from back of queue
remq (Queue1 xs)
    | ismt (Queue1 xs) = error "Cannot remove from empty queue"
    | otherwise = (last xs, Queue1 (init xs))

-- *Main> a = addq 10 mtq
-- *Main> b = addq 9 a
-- *Main> c = addq 8 b
-- *Main> d = addq 7 c
-- *Main> e = addq 6 d
-- *Main> f = addq 5 e
-- *Main> g = addq 4 f
-- *Main> h = addq 3 g
-- *Main> h
-- Queue1 [3,4,5,6,7,8,9,10]
-- *Main> i = remq h
-- *Main> i
-- (10,Queue1 [3,4,5,6,7,8,9])
-- *Main> j = remq (snd i)
-- *Main> j
-- (9,Queue1 [3,4,5,6,7,8])
-- *Main> remq mtq
-- *** Exception: Cannot remove from empty queue
-- CallStack (from HasCallStack):
--   error, called at ./Queue1.hs:36:24 in main:Queue1
