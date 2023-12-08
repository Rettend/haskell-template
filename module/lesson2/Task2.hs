module Task2 where

-- | Task #1
doMath :: (Int -> Int -> Int) -> Int -> Int -> Int
doMath = flip

-- >>> doMath (-) 5 3