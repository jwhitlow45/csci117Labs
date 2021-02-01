---- Part 1: Basic structural recursion ----------------

-- 1. Merge sort

-- Deal a list into two (almost) equal-sizes lists by alternating elements
-- For example, deal [1,2,3,4,5,6,7] = ([1,3,5,7], [2,4,6])
-- and          deal   [2,3,4,5,6,7] = ([2,4,6], [3,5,7])
-- Hint: notice what's happening between the answers to deal [2..7] and
-- deal (1:[2..7]) above to get an idea of how to approach the recursion
--deal :: [a] -> ([a],[a])
--deal [] = ([],[])
--deal (x:xs) = let (ys,zs) = deal xs
--              in (x:zs,ys)  --place x into zs, then ys, alternating until the list is empty

--Now implement merge and mergesort (ms), and test with some
--scrambled lists to gain confidence that your code is correct
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys --append rest of ys onto end of list
merge xs [] = xs --append rest of xs only end of list
merge (x:xs) (y:ys)
  | x <= y = merge (x) (y)
  | x > y  = merge (y) (x)

--ms :: Ord a => [a] -> [a]
--ms [] = []
--ms [x] = [x]
--ms xs = merge () ()   -- general case: deal, recursive call, merge