{- a custom monad, example in <<learn You a Haskell for Great Good>> -}
import Data.Ratio
import Control.Applicative

testP = Prob [(1,1%4),(2,1%2),(4,1%4)]

nestP = Prob [ (Prob [("In1",1%3),("In2",2%3)], 1%3)
             , (Prob [("In3",1%3),("In4",2%2)], 2%3)
             ]
newtype Prob a = Prob { getProb :: [(a, Rational)] } deriving Show

instance Functor Prob where
    fmap f (Prob xs) = Prob $ map (\(a, r) -> (f a, r)) xs

flat :: Prob (Prob a) -> Prob a
flat (Prob xs) = Prob $ concat $ map expand xs 
                where expand (Prob ys, r) = map (\(y, r') -> (y, r'*r)) ys

instance Applicative Prob where
    pure = return

instance Monad Prob where
    return x = Prob [(x,1%1)]
    x >>= f = flat (fmap f x)
    fail _ = Prob []

data Coin = Heads | Tails deriving (Show, Eq)

coin :: Prob Coin
coin = Prob [(Heads,1%2),(Tails,1%2)]

loaderCoin :: Prob Coin
loaderCoin = Prob [(Heads,1%10),(Tails,9%10)]

filpThree :: Prob Bool
filpThree = do
    a <- coin           -- a = [(Heads,1%2),(Tails,1%2)]
    b <- coin           -- b = [(Heads,1%2),(Tails,1%2)]
    c <- loaderCoin     -- c = [(Heads,1%10),(Tails,9%10)]
    return (all (==Tails) [a, b, c])

test = do 
    a <- coin
    b <- coin
    return ([a,b])
