import Data.List (break)

type Name = String
type Data = String
data FSItem = File Name Data | Folder Name [FSItem] 

data FSCrumb = FSCrumb Name [FSItem] [FSItem] deriving (Show)
type FSZipper = (FSItem, [FSCrumb])

x -: f = f x

myDisk :: FSItem
myDisk = 
    Folder "/"
        [ File "kernel" "kernel" 
        , Folder "usr"
            [ File "la" "Ordinary User"
            , File "root" "Super User"
            ]
        , Folder "lib"
            [ Folder "lib" []
            , Folder "lib64" []
            ]
        , Folder "bin"
            [ File "ls" "list file and folder"
            , File "cat" "catenate"
            , File "tac" "etanetac"
            , Folder "RailGun"
                [ File "LEVEL 5" "N/A"
                , File "COIN" "N/A"
                ]
            ]
        ]

instance Show FSItem where
    show = show' 0
show' :: Int -> FSItem -> String
show' level (File name dat) = "\n"
                               ++ (replicate (level*4) ' ') 
                               ++ "FileName: " 
                               ++ name 
                               ++ " Data: " 
                               ++ dat

show' level (Folder name fs) = "\n" 
                               ++ (replicate (level*4) ' ') 
                               ++ "FolderName: " 
                               ++ name
                               ++  concat (map (show' (level+1)) fs)
                               --   str  [str]  fsitem -> str  [fsitem]

fsUp :: FSZipper -> Maybe FSZipper
fsUp (item, FSCrumb name [ls] [rs]:fs) = Just (Folder name ([ls] ++ [item] ++ [rs]), fs)
fsUp (_, []) = Nothing

-- break (==1) [5,4,1,3,2] 
-- ([5,4], [1,3,2])
fsTo :: Name -> FSZipper -> Maybe FSZipper
fsTo name (Folder foldername items , fs) = 
    let (ls, item:rs) = break (nameIs name) items
    in Just (item, FSCrumb foldername ls rs:fs)
fsTo _ (File _ _ , _) = Nothing

nameIs :: Name -> FSItem -> Bool
nameIs name (Folder floderName _) = name == floderName
nameIs name (File fileName _) = name == fileName

fsRename :: Name -> FSZipper -> Maybe FSZipper
fsRename name (Folder foldername items, fs) = Just (Folder name items, fs)
fsRename name (File fileName dat, fs) = Just (File name dat, fs)

fsNew ::FSItem -> FSZipper -> Maybe FSZipper
fsNew newItem (Folder name items, fs)= Just (Folder name (newItem:items), fs)
fsNew _ (File _ _, _) = Nothing

