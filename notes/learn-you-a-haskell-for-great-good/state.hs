import Control.Monad.State

addStuff :: Int -> Int
addStuff = do
    a <- (*2)
    b <- (+10)
    return (a + b)

addStuff' :: Int -> Int
addStuff' = (*2) >>= (\a ->
            (+10) >>= (\b ->
            return (a + b)))

type Stack = [Int]

pop :: State Stack Int
pop = state $ \(x:xs) -> (x, xs)

push :: Int -> State Stack ()
push a = state $ \xs -> ((), a:xs)

test :: State Stack Int
test = do
    push 3
    push 4
    push 5
    pop 

test' :: State Stack Int
test' = push 3 >>= (\_ -> 
        push 4 >>= (\_ ->
        push 5 >>= (\_ ->
        pop)))

test'' :: State Stack Int 
test'' = push 3 >>= (\_ -> push 4) >>= (\_ -> push 5) >>= (\_ -> pop)

{-
    (>>=) :: State s a -> (a -> State s b) -> State s b
        (act1 >>= fact2) s = runState act2 is 
        where (iv,is) = runState act1 s
              act2 = fact2 iv
        
        runState  pop >>= push [1..5]


         
        runState act2 is
        runState (push 1) [2..5]
        where (iv, is) = runState pop [1..5]
                1 [2..5]
                act2 = push iv
                             1

 - -}
