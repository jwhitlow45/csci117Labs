-- CSci 117, Lab 1:  Introduction to Haskell

---------------- Part 1 ----------------

-- WORK through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.


---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and lists.  In Part 2 of this lab, you will catalog many
-- of these functions.

-- Below is the definition of a new Color type (also called an
-- "enumeration type").  You will be using this, when you can, in
-- experimenting with the functions and operators below.
data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)

-- For each of the Prelude functions listed below, give its type,
-- describe briefly in your own words what the function does, answer
-- any questions specified, and give several examples of its use,
-- including examples involving the Color type, if appropriate (note
-- that Color, by the deriving clause, is an Eq, Ord, and Enum type).
-- Include as many examples as necessary to illustration all of the
-- features of the function.  Put your answers inside {- -} comments.
-- I've done the first one for you (note that "Î»: " is my ghci prompt).


-- succ, pred ----------------------------------------------------------------

{- 
succ :: Enum a => a -> a
pred :: Enum a => a -> a

For any Enum type, succ gives the next element of the type after the
given one, and pred gives the previous. Asking for the succ of the
last element of the type, or the pred of the first element of the type
results in an error.

Î»: succ 5
6
Î»: succ 'd'
'e'
Î»: succ False
True
Î»: succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument
Î»: succ Orange
Yellow
Î»: succ Violet
*** Exception: succ{Color}: tried to take `succ' of last tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
Î»: pred 6
5
Î»: pred 'e'
'd'
Î»: pred True
False
Î»: pred False
*** Exception: Prelude.Enum.Bool.pred: bad argument
Î»: pred Orange
Red()
Î»: pred Red
*** Exception: pred{Color}: tried to take `pred' of first tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
-}


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------
All of the functions in this section work only for enumerated types.
toEnum :: Enum a => Int -> a
    Takes an integer and finds the element at that index in the enumerated type starting at 0
Prelude> (toEnum 3) :: Color
Green
Prelude> (toEnum 0) :: Color
Red
Prelude> (toEnum -1) :: Color

<interactive>:5:2: error:
    • Couldn't match expected type ‘Color’ with actual type ‘Int -> a0’
    • Probable cause: ‘(-)’ is applied to too few arguments
      In the expression: (toEnum - 1) :: Color
      In an equation for ‘it’: it = (toEnum - 1) :: Color

toEnum :: Enum a => Int -> a
    Takes an enumerated element and returns the index in the enumerated type the element exists at
Prelude> enumFrom Violet
[Violet]
Prelude> fromEnum Red
0
Prelude> fromEnum Violet
5
Prelude> fromEnum Green
3

enumFrom :: Enum a => a -> [a]
    Returns a list containing a given element in an enumerated type and every element which comes after it.
Prelude> enumFrom Red
[Red,Orange,Yellow,Green,Blue,Violet]
Prelude> enumFrom Blue
[Blue,Violet]
Prelude> enumFrom Yellow
[Yellow,Green,Blue,Violet]
Prelude> enumFrom 0 --truncated output due to size
[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179

enumFromThen :: Enum a => a -> a -> [a]
    Returns a list containing a given element, and every element n indices after it in the enumerated type,
    where n is the distance between the first given element and the second given element
Prelude> enumFromThen Red Green
[Red,Green]
Prelude> enumFromThen Red Blue
[Red,Blue]
Prelude> enumFromThen Red Orange
[Red,Orange,Yellow,Green,Blue,Violet]
Prelude> enumFromThen Red Yellow
[Red,Yellow,Blue]
Prelude> enumFromThen Orange Green 
[Orange,Green,Violet]
Prelude> enumFromThen 0 2 10

<interactive>:19:1: error:
    • Couldn't match expected type ‘Integer -> t’
                  with actual type ‘[Integer]’
    • The function ‘enumFromThen’ is applied to three arguments,
      but its type ‘Integer -> Integer -> [Integer]’ has only two
      In the expression: enumFromThen 0 2 10
      In an equation for ‘it’: it = enumFromThen 0 2 10
    • Relevant bindings include it :: t (bound at <interactive>:19:1)
Prelude> enumFromThen 0 2   --truncated output due to size
[0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,9
Prelude> enumFromThen Violet Blue
[Violet,Blue,Green,Yellow,Orange,Red]
Prelude> enumFromThen Violet Green
[Violet,Green,Orange]


enumFromTo :: Enum a => a -> a -> [a]
    Returns a list containing every element from a given lesser element to a given greater element.
    Returns an empty list if the first element given is greater than the second element.
Prelude> enumFromTo 0 2
[0,1,2]
Prelude> enumFromTo 2 0
[]
Prelude> enumFromTo Red Blue
[Red,Orange,Yellow,Green,Blue]
Prelude> enumFromTo Blue Red
[]
Prelude> enumFromTo -3 3

<interactive>:37:1: error:
    • Non type-variable argument in the constraint: Num (a -> a -> [a])
      (Use FlexibleContexts to permit this)
    • When checking the inferred type
        it :: forall a t.
              (Enum a, Num t, Num (a -> a -> [a]), Num (t -> a -> a -> [a])) =>
              a -> a -> [a]
Prelude> enumFromTo (-3) 3
[-3,-2,-1,0,1,2,3]
Prelude> enumFromTo 3 (-3)
[]

enumFromThenTo :: Enum a => a -> a -> a -> [a]
    Returns a list containing the first given element, and every element n indicies after it up to m,
    where n is the distance between the first and second given eleme1nt, and m is the third given element.
    Returns an empty list if the distance between the first and second element does not allow for the third
    element to be reached. Such is the case in enumFromThenTo 1 (-2) 9.
Prelude> enumFromThenTo 0 3 9
[0,3,6,9]
Prelude> enumFromThenTo 0 2 9
[0,2,4,6,8]
Prelude> enumFromThenTo Red 1 Violet

<interactive>:46:20: error:
    • No instance for (Num Color) arising from the literal ‘1’
    • In the second argument of ‘enumFromThenTo’, namely ‘1’
      In the expression: enumFromThenTo Red 1 Violet
      In an equation for ‘it’: it = enumFromThenTo Red 1 Violet
Prelude> enumFromThenTo Red Blue Violet
[Red,Blue]
Prelude> enumFromThenTo Red Orange Violet
[Red,Orange,Yellow,Green,Blue,Violet]
Prelude> enumFromThenTo Red Yellow Violet
[Red,Yellow,Blue]
Prelude> enumFromThenTo 1 3 9
[1,3,5,7,9]
Prelude> enumFromThenTo 1 3 0
[]
Prelude> enumFromThenTo 1 (-2) 9
[]



-- As one of your examples, try  (toEnum 3) :: Color --------------------------

-- ==, /= ---------------------------------------------------------------------
(==) :: Eq a => a -> a -> Bool
(/=) :: Eq a => a -> a -> Bool
    For any equality type, == returns True if the two element which are being compared are equivalent, and False if they are not.
    Furthermore, /= returns True if two elements are not equivalent, and False if they are not. An error is presented if two
    elements are not of the same type and therefore cannot be compared.
Prelude> True == True
True
Prelude> 0 == 1
False
Prelude> 1 == True

<interactive>:61:1: error:
    • No instance for (Num Bool) arising from the literal ‘1’
    • In the first argument of ‘(==)’, namely ‘1’
      In the expression: 1 == True
      In an equation for ‘it’: it = 1 == True
Prelude> 'a' == 'a'
True
Prelude> 'a' == 'A'
False
Prelude> 'a' == 97

<interactive>:64:8: error:
    • No instance for (Num Char) arising from the literal ‘97’
    • In the second argument of ‘(==)’, namely ‘97’
      In the expression: 'a' == 97
      In an equation for ‘it’: it = 'a' == 97

Prelude> 0 /= 1
True
Prelude> 0 /= 0
False
Prelude> False /= True
True
Prelude> 'a' /= 9

<interactive>:67:8: error:
    • No instance for (Num Char) arising from the literal ‘9’
    • In the second argument of ‘(/=)’, namely ‘9’
      In the expression: 'a' /= 9
      In an equation for ‘it’: it = 'a' /= 9

-- quot, div (Q: what is the difference? Hint: negative numbers) --------------
quot :: Integral a => a -> a -> a
div :: Integral a => a -> a -> a
    For any integral type, quot and div both perform and return the result of integer division between the first and second given elements.
    However quot is truncated towards zero causing it to "round up" during the division of negative numbers. Div is
    truncated towards negative infinity causing it to "round down" during the division of negative numbers. Because of 
    this both functions behave identically when dividing positive numbers. Floating points, even when divided by one
    another, return an error. Diving by 0 provides a divide by 0 exception.

Prelude> quot 10 3
3
Prelude> quot 10 (-3)
-3
Prelude> quot (-10) 3
-3
Prelude> quot (-10) 0
*** Exception: divide by zero
Prelude> quot (-10) 3.9

<interactive>:74:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Color -- Defined at <interactive>:5:70
        ...plus 23 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it
Prelude> quot (-10.5) 3.9

<interactive>:75:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Color -- Defined at <interactive>:5:70
        ...plus 23 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it

Prelude> div 10 3
3
Prelude> div 10 (-3)
-4
Prelude> div (-10) 3
-4
Prelude> div (-12) 3
-4
Prelude> div (-12) 0
*** Exception: divide by zero
Prelude> div (-12) 1.3

<interactive>:81:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Color -- Defined at <interactive>:5:70
        ...plus 23 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it
Prelude> div (-12.2) 1.3

<interactive>:82:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Color -- Defined at <interactive>:5:70
        ...plus 23 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it
Prelude> div (-12.2) 1

<interactive>:83:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Color -- Defined at <interactive>:5:70
        ...plus 23 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it

-- rem, mod  (Q: what is the difference? Hint: negative numbers) --------------
rem :: Integral a => a -> a -> a
mod :: Integral a => a -> a -> a
    For any integral type, rem returns the remainder of the integer division of the first and second given elements.
    Mod also returns the remainder but behaves differently when only one of the given elements are negative. For example
    rem 10 (-3) returns 1 whereas mod 10 (-3) returns -2. This is because rem effectively ignores the negative number,
    performing the operation as if both elements were positive. Mod follows the forumla a-b*floor(a/b) which is what
    results in different answers when one of the elements is negative. Both of these operations, as with quot and div,
    return a divide by 0 error when dividing by 0. Neither of these operations can handle floating point numbers and
    return errors in those instances.


Prelude> rem 10 3
1
Prelude> rem 10 (-3)
1
Prelude> rem 10 2
0
Prelude> rem 10 4
2
Prelude> rem 10 (-4)
2
Prelude> rem 116 (-4)
0
Prelude> rem 116 4
0
Prelude> rem 116 0
*** Exception: divide by zero
Prelude> rem 116 2.0

<interactive>:110:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Color -- Defined at <interactive>:5:70
        ...plus 23 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it

Prelude> mod 10 3
1
Prelude> mod 3 10
3
Prelude> mod 3 3
0
Prelude> mod 3 (-3)
0
Prelude> mod 10 (-3)
-2
Prelude> mod 10 (-2)
0
Prelude> mod 10 (-4)
-2
Prelude> mod 15 (-4)
-1
Prelude> mod 15 (-3)
0
Prelude> mod 15 (-6)
-3
Prelude> mod 15 (-6.0)

<interactive>:122:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Color -- Defined at <interactive>:5:70
        ...plus 23 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it

-- quotRem, divMod ------------------------------------------------------------
quotRem :: Integral a => a -> a -> (a, a)
divMod :: Integral a => a -> a -> (a, a)
    For any integral type, quotRem and divMod return the result of their respective operations in a tuple.
    If the second element is 0 then the operation returns a divide by zero exception. Both operations throw an
    error when a floating point value is present.

Prelude> quotRem 10 3
(3,1)
Prelude> quotRem 10 (-3)
(-3,1)
Prelude> quotRem 10 0
*** Exception: divide by zero
Prelude> quotRem 10 1.0

<interactive>:15:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Ghci1.Color -- Defined at <interactive>:1:70
        ...plus 24 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it

Prelude> divMod 10 3
(3,1)
Prelude> divMod 10 (-3)
(-4,-2)
Prelude> divMod 10 0
*** Exception: divide by zero
Prelude> divMod 10 1.0

<interactive>:14:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘print’
      prevents the constraint ‘(Show a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Show Ordering -- Defined in ‘GHC.Show’
        instance Show Integer -- Defined in ‘GHC.Show’
        instance [safe] Show Ghci1.Color -- Defined at <interactive>:1:70
        ...plus 24 others
        ...plus 19 instances involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In a stmt of an interactive GHCi command: print it

-- &&, || ---------------------------------------------------------------------
(&&) :: Bool -> Bool -> Bool
(||) :: Bool -> Bool -> Bool
    For any Bool type, returns the result of the algebraic logic operations AND (&&) and OR (||). If
    presented with any other type an error is thrown. 0 and 1 are not typecasted to Bool as in some
    other languages.
Prelude> True && True
True
Prelude> True && False
False
Prelude> False && False
False
Prelude> 0 && False

<interactive>:21:1: error:
    • No instance for (Num Bool) arising from the literal ‘0’
    • In the first argument of ‘(&&)’, namely ‘0’
      In the expression: 0 && False
      In an equation for ‘it’: it = 0 && False
Prelude> True || True
True
Prelude> True || False
True
Prelude> False || False
False
Prelude> 0 || False

<interactive>:25:1: error:
    • No instance for (Num Bool) arising from the literal ‘0’
    • In the first argument of ‘(||)’, namely ‘0’
      In the expression: 0 || False
      In an equation for ‘it’: it = 0 || False


-- ++ -------------------------------------------------------------------------
(++) :: [a] -> [a] -> [a]
    For any list, the first given list has the second given list appended onto the end of it. Elements 
    in each respective list must be of the same type otherwise an error is thrown.
Prelude> [1,2,3]++[4,5,6]
[1,2,3,4,5,6]
Prelude> [1,2,3]++[]
[1,2,3]
Prelude> []++[]
[]
Prelude> [1,2,3]++["dog"]

<interactive>:30:2: error:
    • No instance for (Num [Char]) arising from the literal ‘1’
    • In the expression: 1
      In the first argument of ‘(++)’, namely ‘[1, 2, 3]’
      In the expression: [1, 2, 3] ++ ["dog"]
Prelude> [1,2,3]++['a']

<interactive>:31:2: error:
    • No instance for (Num Char) arising from the literal ‘1’
    • In the expression: 1
      In the first argument of ‘(++)’, namely ‘[1, 2, 3]’
      In the expression: [1, 2, 3] ++ ['a']
Prelude> ["dog"]++["cat"]
["dog","cat"]
Prelude> [2,"dog"]++[1,"cat"]

<interactive>:33:2: error:
    • No instance for (Num [Char]) arising from the literal ‘2’
    • In the expression: 2
      In the first argument of ‘(++)’, namely ‘[2, "dog"]’
      In the expression: [2, "dog"] ++ [1, "cat"]

-- compare --------------------------------------------------------------------
compare :: Ord a => a -> a -> Ordering
    For any Ordered type, returns the relationship of the first given element to the second given element
    in the form LT (less than), EQ (equal), or GT (greater than). Elements must be of the same type otherwise
    an error will be thrown.

Prelude> compare 10 2
GT
Prelude> compare "dog" "cat"
GT
Prelude> compare "cog" "cat"
GT
Prelude> compare "cag" "cat"
LT
Prelude> compare "cat" "cat"
EQ
Prelude> compare 'a' 'a'
EQ
Prelude> compare 'a' 'A'
GT
Prelude> compare 2 10
LT
Prelude> compare 2 2
EQ
Prelude> compare 2 'a'

<interactive>:49:9: error:
    • No instance for (Num Char) arising from the literal ‘2’
    • In the first argument of ‘compare’, namely ‘2’
      In the expression: compare 2 'a'
      In an equation for ‘it’: it = compare 2 'a'

-- <, > -----------------------------------------------------------------------
(<) :: Ord a => a -> a -> Bool
(>) :: Ord a => a -> a -> Bool
    For any pair of Ordered types, returns the Boolean result of the first element less than (<) or greater
    than (>) the second element. An error is returned if the first and second element are of different types.

Prelude> 10<12
True
Prelude> 11<12
True
Prelude> 11<9
False
Prelude> 10>9
True
Prelude> 10>90
False
Prelude> 90>90
False
Prelude> 'a'<'b'
True
Prelude> 'a'>'b'
False
Prelude> 'a'>'A'
True
Prelude> 'a'>10

<interactive>:62:5: error:
    • No instance for (Num Char) arising from the literal ‘10’
    • In the second argument of ‘(>)’, namely ‘10’
      In the expression: 'a' > 10
      In an equation for ‘it’: it = 'a' > 10
Prelude> "string"<"dog"
False

-- max, min -------------------------------------------------------------------
max :: Ord a => a -> a -> a
min :: Ord a => a -> a -> a
    For any pair of Ordered types, returns the max or min of the given pair. Returns an error if the elements
    in the pair are not of the same type.

Prelude> max 9 10
10
Prelude> max 10 9
10
Prelude> max 'a' 'b'
'b'
Prelude> max 'a' 10

<interactive>:72:9: error:
    • No instance for (Num Char) arising from the literal ‘10’
    • In the second argument of ‘max’, namely ‘10’
      In the expression: max 'a' 10
      In an equation for ‘it’: it = max 'a' 10
Prelude> max "dog" "cat"
"dog"
Prelude> min 9 10
9
Prelude> min 10 9
9
Prelude> min 'a' 'b'
'a'
Prelude> min 'a' 10

<interactive>:77:9: error:
    • No instance for (Num Char) arising from the literal ‘10’
    • In the second argument of ‘min’, namely ‘10’
      In the expression: min 'a' 10
      In an equation for ‘it’: it = min 'a' 10
Prelude> min "dog" "cat"
"cat"

-- ^ --------------------------------------------------------------------------
(^) :: (Integral b, Num a) => a -> b -> a
    For any Integral type b, and a number type a, performs the mathematical exponent operation in the form
    a ^ b. Characters are not type casted to integers. If b is a floating point number an error is thrown.

Prelude> 2 ^ 7
128
Prelude> 2.5 ^ 7
610.3515625
Prelude> 2.5 ^ 7.1

<interactive>:87:1: error:
    • Could not deduce (Integral b0) arising from a use of ‘^’
      from the context: Fractional a
        bound by the inferred type of it :: Fractional a => a
        at <interactive>:87:1-9
      The type variable ‘b0’ is ambiguous
      These potential instances exist:
        instance Integral Integer -- Defined in ‘GHC.Real’
        instance Integral Int -- Defined in ‘GHC.Real’
        instance Integral Word -- Defined in ‘GHC.Real’
        ...plus one instance involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In the expression: 2.5 ^ 7.1
      In an equation for ‘it’: it = 2.5 ^ 7.1

<interactive>:87:7: error:
    • Could not deduce (Fractional b0) arising from the literal ‘7.1’
      from the context: Fractional a
        bound by the inferred type of it :: Fractional a => a
        at <interactive>:87:1-9
      The type variable ‘b0’ is ambiguous
      These potential instances exist:
        instance Fractional Double -- Defined in ‘GHC.Float’
        instance Fractional Float -- Defined in ‘GHC.Float’
        ...plus one instance involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In the second argument of ‘(^)’, namely ‘7.1’
      In the expression: 2.5 ^ 7.1
      In an equation for ‘it’: it = 2.5 ^ 7.1
Prelude> 2 ^ 7.1

<interactive>:88:1: error:
    • Could not deduce (Integral b0) arising from a use of ‘^’
      from the context: Num a
        bound by the inferred type of it :: Num a => a
        at <interactive>:88:1-7
      The type variable ‘b0’ is ambiguous
      These potential instances exist:
        instance Integral Integer -- Defined in ‘GHC.Real’
        instance Integral Int -- Defined in ‘GHC.Real’
        instance Integral Word -- Defined in ‘GHC.Real’
        ...plus one instance involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In the expression: 2 ^ 7.1
      In an equation for ‘it’: it = 2 ^ 7.1

<interactive>:88:5: error:
    • Could not deduce (Fractional b0) arising from the literal ‘7.1’
      from the context: Num a
        bound by the inferred type of it :: Num a => a
        at <interactive>:88:1-7
      The type variable ‘b0’ is ambiguous
      These potential instances exist:
        instance Fractional Double -- Defined in ‘GHC.Float’
        instance Fractional Float -- Defined in ‘GHC.Float’
        ...plus one instance involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In the second argument of ‘(^)’, namely ‘7.1’
      In the expression: 2 ^ 7.1
      In an equation for ‘it’: it = 2 ^ 7.1
Prelude> 2.5 ^ 'a'

<interactive>:89:1: error:
    • Could not deduce (Integral Char) arising from a use of ‘^’
      from the context: Fractional a
        bound by the inferred type of it :: Fractional a => a
        at <interactive>:89:1-9
    • In the expression: 2.5 ^ 'a'
      In an equation for ‘it’: it = 2.5 ^ 'a'
Prelude> 'a' ^ 12

<interactive>:90:1: error:
    • No instance for (Num Char) arising from a use of ‘^’
    • In the expression: 'a' ^ 12
      In an equation for ‘it’: it = 'a' ^ 12


-- concat ---------------------------------------------------------------------
concat :: Foldable t => t [a] -> [a]
    For any foldable type, concatonates a list of lists into a singular list. Since strings are lists of characters
    these can be concatonated using concat as such: concat ["dog","cat"] returns "dogcat". Returns an error if the
    types the lists are different from one another.
Prelude> concat [[3,2],[2,3]]
[3,2,2,3]
Prelude> concat "string"

<interactive>:95:8: error:
    • Couldn't match type ‘Char’ with ‘[a]’
      Expected type: [[a]]
        Actual type: [Char]
    • In the first argument of ‘concat’, namely ‘"string"’
      In the expression: concat "string"
      In an equation for ‘it’: it = concat "string"
    • Relevant bindings include it :: [a] (bound at <interactive>:95:1)
Prelude> concat ["string", "test"]
"stringtest"
Prelude> concat ['a','a']

<interactive>:97:9: error:
    • Couldn't match expected type ‘[a]’ with actual type ‘Char’
    • In the expression: 'a'
      In the first argument of ‘concat’, namely ‘['a', 'a']’
      In the expression: concat ['a', 'a']
    • Relevant bindings include it :: [a] (bound at <interactive>:97:1)

<interactive>:97:13: error:
    • Couldn't match expected type ‘[a]’ with actual type ‘Char’
    • In the expression: 'a'
      In the first argument of ‘concat’, namely ‘['a', 'a']’
      In the expression: concat ['a', 'a']
    • Relevant bindings include it :: [a] (bound at <interactive>:97:1)
Prelude> concat [[1,2,3]['a','b','c']]

<interactive>:98:9: error:
    • Couldn't match expected type ‘[Char] -> [a]’
                  with actual type ‘[Integer]’
    • The function ‘[1, 2, 3]’ is applied to one argument,
      but its type ‘[Integer]’ has none
      In the expression: [1, 2, 3] ['a', 'b', 'c']
      In the first argument of ‘concat’, namely
        ‘[[1, 2, 3] ['a', 'b', ....]]’
    • Relevant bindings include it :: [a] (bound at <interactive>:98:1)

-- const ----------------------------------------------------------------------
const :: a -> b -> a


-- cycle ----------------------------------------------------------------------
cycle :: [a] -> [a]
    For any list, returns a repeating, neverending list cycling through the elements in the list. When the final
    element of the list is reached the cycle resumes at the first element of the list. Returns an error if any
    elements in the list are not of the same type.
Prelude> cycle [1,4,'a']
    G
Prelude> cycle [1,4,1]
[1,4,1,1,4,1,1,4,1,1,4,1,1,4,1
<interactive>:2:8: error:
    • No instance for (Num Char) arising from the literal ‘1’
    • In the expression: 1
      In the first argument of ‘cycle’, namely ‘[1, 4, 'a']’
      In the expression: cycle [1, 4, 'a']
Prelude> cycle ["string"]
["string","string","string","string","string"...
-- drop, take -----------------------------------------------------------------
drop :: Int -> [a] -> [a]
take :: Int -> [a] -> [a]
    For any Integer type given a List, drop returns the list with n number of elements removed from the front of the list,
    where n is the Integer type. Take returns the list containing n number of elements from the start of the list, where n
    is the Integer type. Drop returns an empty list when n is greater than the size of the list, and take returns the original
    list when n is greater than the size of the list. Both operations throw an error when n is a negative Integer.

Prelude> drop 2 [2,3,4]
[4]
Prelude> drop 1 [2,3,4]
[3,4]
Prelude> drop 0 [2,3,4]
[2,3,4]
Prelude> drop 4 [2,3,4]
[]
Prelude> drop -1 [2,3,4]

<interactive>:7:1: error:
    • Non type-variable argument
        in the constraint: Num ([a1] -> Int -> [a2] -> [a2])
      (Use FlexibleContexts to permit this)
    • When checking the inferred type
        it :: forall a1 a2.
              (Num a1, Num ([a1] -> Int -> [a2] -> [a2]),
               Num (Int -> [a2] -> [a2])) =>
              Int -> [a2] -> [a2]

Prelude> take 1 [2,3,4]
[2]
Prelude> take 2 [2,3,4]
[2,3]
Prelude> take 0 [2,3,4]
[]
Prelude> take 4 [2,3,4]
[2,3,4]
Prelude> take -1 [2,3,4]

<interactive>:8:1: error:
    • Non type-variable argument
        in the constraint: Num ([a1] -> Int -> [a2] -> [a2])
      (Use FlexibleContexts to permit this)
    • When checking the inferred type
        it :: forall a1 a2.
              (Num a1, Num ([a1] -> Int -> [a2] -> [a2]),
               Num (Int -> [a2] -> [a2])) =>
              Int -> [a2] -> [a2]

-- elem -----------------------------------------------------------------------
elem :: (Foldable t, Eq a) => a -> t a -> Bool
    For any Foldable type t, and Equivalent type a, elem returns a Boolean. True is returned if a is in
    t, and False is returned if a is not in t. In simpler terms elem checks if a is an element in t. Elem
    throws an error if the type a is not the same as the elements in type t.
Prelude> elem 4 [2,3,4]
True
Prelude> elem 1 [2,3,4]
False
Prelude> elem 'a' [2,3,4]

<interactive>:13:11: error:
    • No instance for (Num Char) arising from the literal ‘2’
    • In the expression: 2
      In the second argument of ‘elem’, namely ‘[2, 3, 4]’
      In the expression: elem 'a' [2, 3, 4]
Prelude> elem 2 [2,3,4]
True
Prelude> elem 3 [2,3,4]
True
Prelude> elem 'a' ['a','b','c']
True
Prelude> elem 'd' ['a','b','c']
False
Prelude> elem 1 ['a','b','c']

<interactive>:18:6: error:
    • No instance for (Num Char) arising from the literal ‘1’
    • In the first argument of ‘elem’, namely ‘1’
      In the expression: elem 1 ['a', 'b', 'c']
      In an equation for ‘it’: it = elem 1 ['a', 'b', 'c']
Prelude> elem 'd' ["test"]

<interactive>:19:11: error:
    • Couldn't match expected type ‘Char’ with actual type ‘[Char]’
    • In the expression: "test"
      In the second argument of ‘elem’, namely ‘["test"]’
      In the expression: elem 'd' ["test"]
Prelude> elem 'd' "test"
False
Prelude> elem 'e' "test"
True

-- even -----------------------------------------------------------------------
even :: Integral a => a -> Bool
    For any Integral type a, returns a Bool if a is even and false if it is not even. Does not typecast characters
    to an Integral and throws an error in instances with a char type as the argument. Also throws an error when
    floating point numbers are present.
Prelude> even 23
False
Prelude> even 2
True
Prelude> even 'a'

<interactive>:27:1: error:
    • No instance for (Integral Char) arising from a use of ‘even’
    • In the expression: even 'a'
      In an equation for ‘it’: it = even 'a'
Prelude> even "cats"

<interactive>:28:1: error:
    • No instance for (Integral [Char]) arising from a use of ‘even’
    • In the expression: even "cats"
      In an equation for ‘it’: it = even "cats"
Prelude> even -2

<interactive>:29:1: error:
    • Non type-variable argument in the constraint: Num (a -> Bool)
      (Use FlexibleContexts to permit this)
    • When checking the inferred type
        it :: forall a. (Integral a, Num (a -> Bool)) => a -> Bool
Prelude> even 0
True
Prelude> even (-2)
True
Prelude> even (-9)
False
Prelude> even 0.0

<interactive>:34:1: error:
    • Ambiguous type variable ‘a0’ arising from a use of ‘even’
      prevents the constraint ‘(Integral a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Integral Integer -- Defined in ‘GHC.Real’
        instance Integral Int -- Defined in ‘GHC.Real’
        instance Integral Word -- Defined in ‘GHC.Real’
        ...plus one instance involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In the expression: even 0.0
      In an equation for ‘it’: it = even 0.0

<interactive>:34:6: error:
    • Ambiguous type variable ‘a0’ arising from the literal ‘0.0’
      prevents the constraint ‘(Fractional a0)’ from being solved.
      Probable fix: use a type annotation to specify what ‘a0’ should be.
      These potential instances exist:
        instance Fractional Double -- Defined in ‘GHC.Float’
        instance Fractional Float -- Defined in ‘GHC.Float’
        ...plus one instance involving out-of-scope types
        (use -fprint-potential-instances to see them all)
    • In the first argument of ‘even’, namely ‘0.0’
      In the expression: even 0.0
      In an equation for ‘it’: it = even 0.0

-- fst ------------------------------------------------------------------------

-- gcd ------------------------------------------------------------------------

-- head -----------------------------------------------------------------------

-- id -------------------------------------------------------------------------

-- init -----------------------------------------------------------------------

-- last -----------------------------------------------------------------------

-- lcm ------------------------------------------------------------------------

-- length ---------------------------------------------------------------------

-- null -----------------------------------------------------------------------

-- odd ------------------------------------------------------------------------

-- repeat ---------------------------------------------------------------------

-- replicate ------------------------------------------------------------------

-- reverse --------------------------------------------------------------------

-- snd ------------------------------------------------------------------------

-- splitAt --------------------------------------------------------------------

-- zip ------------------------------------------------------------------------


-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any -------------------------------------------------------------------

-- break ----------------------------------------------------------------------

-- dropWhile, takeWhile -------------------------------------------------------

-- filter ---------------------------------------------------------------------

-- iterate --------------------------------------------------------------------

-- map ------------------------------------------------------------------------

-- span -----------------------------------------------------------------------
