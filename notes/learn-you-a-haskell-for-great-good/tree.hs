data Tree a = Empty | Node a (Tree a) (Tree a) 

tree :: Tree Int
tree = Node 1 
          (Node 2
              (Node 4
                  (Node 8 Empty Empty)
                  Empty
              )
              (Node 5 Empty Empty)
          )
          (Node 3
              (Node 6 Empty Empty)
              (Node 7 Empty Empty)
          )

instance (Show a) => Show (Tree a) where 
    show = show' 1

{- Show a tree hierarchically -}
show' :: (Show a) => Int -> Tree a -> String
show' level (Node node tl tr) = "Node "
                             ++ Prelude.show node 
                             ++ "\n" ++ replicate (level*4) ' '
                             ++ show' (level + 1) tl
                             ++ "\n" ++ replicate (level*4) ' '
                             ++ show' (level + 1) tr
show' _ Empty = "Empty"

data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show)
type Crumbs a = [Crumb a]
type Zipper a = (Tree a, Crumbs a)

goLeft :: Zipper a -> Maybe (Zipper a)
goLeft (Node node tl tr, bs) = Just (tl, LeftCrumb node tr:bs)
goLeft (Empty, _) = Nothing

goRight :: Zipper a -> Maybe (Zipper a)
goRight (Node node tl tr, bs) = Just (tr, RightCrumb node tl:bs)
goRight (Empty, _) = Nothing

goUp :: Zipper a -> Maybe (Zipper a)
goUp (tl, (LeftCrumb node tr) : bs) = Just (Node node tl tr, bs)
goUp (tr, (RightCrumb node tl) : bs) = Just (Node node tl tr, bs)
goUp (_, []) = Nothing

modify :: (a -> a) -> Zipper a -> Maybe (Zipper a)
modify f (Node node tl tr, bs) = Just (Node (f node) tl tr, bs)
modify f (Empty, bs) =  Just (Empty, bs)

attach :: Tree a -> Zipper a -> Maybe (Zipper a)
attach t (_, bs)= Just (t, bs)


