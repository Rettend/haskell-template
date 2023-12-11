module Submodule.Utils.Test where

import Control.Monad (forM, replicateM, void, when)
import Data.Char (toUpper)
import Data.List (sort)
import Data.Maybe (fromMaybe, isJust, isNothing, listToMaybe, mapMaybe)
import Data.Time.Clock (diffUTCTime, getCurrentTime)
import System.CPUTime (getCPUTime)
import System.Console.ANSI (clearFromCursorToLineEnd, cursorUpLine)
import System.Environment (getArgs)
import Test.HUnit (Counts, PutText (..), Test (..), assertBool, assertEqual, runTestTT, runTestText)
import Text.Printf (printf)
import Text.Read (readMaybe)

run :: Test -> IO ()
run tests = do
  args <- getArgs
  let (testArgs, benchmarkArgs) = break (== "-b") args
  let testNumbers = mapMaybe readMaybe testArgs
  let benchmarkCount = if null benchmarkArgs then Nothing else Just (fromMaybe 1 (listToMaybe $ mapMaybe readMaybe (drop 1 benchmarkArgs)))
  if null testNumbers
    then do
      mapM_ (uncurry (runner benchmarkCount)) (zip [1 ..] (getTests tests))
      putStrLn "Result:"
      void $ runTestTT tests
    else do
      let selectedTests = [(testNumber, getTests tests !! (testNumber - 1)) | testNumber <- testNumbers, testNumber > 0, testNumber <= length (getTests tests)]
      mapM_ (uncurry (runner benchmarkCount)) selectedTests
      putStrLn "Result:"
      void $ runTestTT $ TestList $ map snd selectedTests

runner :: Maybe Int -> Int -> Test -> IO ()
runner benchmarkCount testNumber test = do
  when (isJust benchmarkCount) $ do
    putStrLn $ "Test #" ++ show testNumber
    void $ runTestTT test
    let count = fromMaybe 1 benchmarkCount
    let barLength = 50
    times <- forM [1 .. count] $ \i -> do
      start <- getCPUTime
      _ <- runTestText discardOutput test
      end <- getCPUTime
      let time :: Double = fromIntegral (end - start) / (10 ^ 12)
      let progress = (i * barLength) `div` count
      cursorUpLine 1
      clearFromCursorToLineEnd
      printf "Benchmark %d/%d " i count
      putStrLn $ "Progress: [" ++ replicate progress '█' ++ replicate (barLength - progress) '░' ++ "]"
      return time
    putStrLn $ "Benchmark result: " ++ show (sum times / fromIntegral count) ++ " seconds"
  putStrLn ""

discardOutput :: PutText Int
discardOutput = PutText (\_ _ n -> return (n + 1)) 0

getTests :: Test -> [Test]
getTests (TestList ts) = ts
getTests t = [t]
