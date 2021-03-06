-- Ted Cooper
-- <theod@pdx.edu>
-- Exercise 1

module Ex1 where

import Control.Applicative ((<*>), pure)
import Data.List (permutations, sort, transpose, union)
import Data.Maybe (fromJust)

import SimpleProp


addvars:: Ord a => Prop a -> [a] -> [a] 
addvars (LetterP x)    = union [x]
addvars (AndP x y)     = addvars x . addvars y
addvars (OrP x y)      = addvars x . addvars y
addvars (ImpliesP x y) = addvars x . addvars y
addvars (NotP x)       = addvars x
addvars _              = id

vars:: Ord a => Prop a -> [a] 
vars = flip addvars []

assigns:: [Int] -> [[(Int,Bool)]]
assigns is = map (zip is) $ strings [True, False] is

strings':: [a] -> [b] -> [[a]]
strings' alphabet is = take (n ^ m) . transpose . take m . scanl f (cycle alphabet) $ is
  where n           = length alphabet
        m           = length is 
        f acc r     = slow acc
        slow (x:xs) = replicate n x ++ slow xs

strings:: [a] -> [b] -> [[a]]
strings alphabet (i:is) = [ (x:xs) | x  <- alphabet
                                   , xs <- strings alphabet is ]
strings alphabet []     = [[]]


vfs:: Prop Int -> [Int -> Bool]
vfs = map ((.) fromJust . flip lookup) . assigns . vars

taut:: Prop Int -> Bool
taut p = all (flip value p) . vfs $ p

equal' :: Prop Int -> Prop Int -> Bool
equal' p q = let vfs'  = vfs p
                 fvs p = map (flip value p) $ vfs'
            in sort (vars p) == sort (vars q) && fvs p == fvs q

equal :: Prop Int -> Prop Int -> Bool
equal p q = taut $ (OrP (AndP p q) (AndP (NotP p) (NotP q)))

-- implication test:
-- > equal (ImpliesP (LetterP 1) (LetterP 2)) (OrP (LetterP 2) (NotP (LetterP 1)))
-- True
