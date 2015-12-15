{- a rpn calculator complete by state monad -}
import Control.Monad.State

type Stack = [Double]

push :: Double -> State Stack ()
push elem = do
    s <- get
    put (elem:s)

pop :: State Stack Double 
pop = do
    (elem:s) <- get
    put s
    return elem

test = "5 1 2 + 4 * + 3 -"

sloveRPN :: String -> Double
sloveRPN exp = head . snd  $ runState(calc $ words exp) []
    where calc (x:xs) = do
                folding x
                calc xs
          calc [] = return ()
          
folding :: String -> State Stack ()
folding "+" = do
    a <- pop
    b <- pop
    push (b + a)
folding "-" = do
    a <- pop
    b <- pop
    push (b - a)
folding "*" = do
    a <- pop
    b <- pop
    push (b * a)
folding "/" = do
    a <- pop
    b <- pop
    push (b / a)
folding x = do
    push $ read x

