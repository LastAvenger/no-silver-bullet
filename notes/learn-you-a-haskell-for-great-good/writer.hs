{- #Example of Writer Monad#-}
{- 与do语法等效的>>=表达 -}

import Control.Monad.Writer 
import Control.Monad.Instances

f :: Int -> Writer [String] Int
f x = writer (x + 3, [show x ++ "+3"])

g :: Writer [String] Int
g = return 3 >>= f >>= f

h :: Writer [String] Int
h = return 3 >>= (\x ->
    f x >>= (\y ->
    f y))

i :: Writer [String] Int
i = do
    x <- f 3
    y <- f 4
    return (x * y)

j :: Writer [String] Int
j = f 3 >>= (\x ->
    f 4 >>= (\y ->
    return (x * y)))
