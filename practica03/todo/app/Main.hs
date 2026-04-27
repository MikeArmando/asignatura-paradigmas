import Text.Read (readMaybe)

putTodo :: (Int, String) -> IO ()
putTodo (n, todo) = putStrLn (show n ++ ": " ++ todo)

prompt :: [String] -> IO ()
prompt todos = do
    putStrLn ""
    putStrLn "Current TODO list:"
    mapM_ putTodo (zip [0..] todos)
    command <- getLine
    interpret command todos

deleteAt :: Int -> [a] -> Maybe [a]
deleteAt n xs
    | n < 0 || n >= length xs = Nothing
    | otherwise = Just (take n xs ++ drop (n + 1) xs)

interpret :: String -> [String] -> IO ()
interpret ('+':' ':todo) todos = prompt (todo:todos)
interpret ('-':' ':num ) todos =
    case readMaybe num of
        Nothing -> do
            putStrLn "Invalid number format"
            prompt todos
        Just n ->
            case deleteAt n todos of
                Nothing     -> do
                    putStrLn "No TODO entry matches the given number"
                    prompt todos
                Just todos' -> prompt todos'
interpret "q"     _todos = return ()
interpret command  todos = do
    putStrLn ("Invalid command: `" ++ command ++ "`")
    prompt todos

main :: IO ()
main = do
    putStrLn "Commands:"
    putStrLn "+ <String> - Add a TODO entry"
    putStrLn "- <Int>    - Delete the numbered entry"
    putStrLn "q          - Quit"
    prompt []