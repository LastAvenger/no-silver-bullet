{- a safe rpn calculator -}
import Data.List
import Control.Monad

test = "5 1 2 + 4 * + 3 -"

sloveRPN :: String -> Maybe Double
sloveRPN st = do
        [res] <- foldM folding [] $ words st
        return res

folding :: [Double] -> String -> Maybe [Double]
folding (x:y:ys) "*" = return $ (y*x):ys
folding (x:y:ys) "/" = return $ (y/x):ys
folding (x:y:ys) "+" = return $ (y+x):ys
folding (x:y:ys) "-" = return $ (y-x):ys
folding xs numStr = liftM (:xs) $ readMaybe numStr

readMaybe :: String -> Maybe Double
readMaybe numStr = case reads numStr of 
                                [(x, "")] -> return x
                                _ -> Nothing

