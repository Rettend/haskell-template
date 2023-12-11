module Submodule.Utils.Test where

import Control.Monad (forM, forM_, replicateM, void, when, zipWithM)
import Data.Char (toUpper)
import Data.Function (on)
import Data.List (sort, sortBy)
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
  let summary = "-s" `elem` args
  let selectedTests = if null testNumbers then getTests tests else [test | (_, test) <- [(testNumber, getTests tests !! (testNumber - 1)) | testNumber <- testNumbers, testNumber > 0, testNumber <= length (getTests tests)]]
  results <- zipWithM (runner benchmarkCount) [1 ..] selectedTests
  putStrLn "Result:"
  void $ runTestTT $ TestList $ zipWith (\num test -> TestLabel ("Test #" ++ show num) test) [1 ..] selectedTests
  when summary $ do
    let sortedResults = sortBy (flip compare `on` (\(_, _, time) -> time)) results
    let maxNameLength = maximum $ map (length . (\(_, name, _) -> name)) sortedResults
    printf "Test Number | Test Name%s | Average Time\n" (replicate (maxNameLength - 9) ' ')
    putStrLn $ replicate (maxNameLength + 35) '-'
    forM_ sortedResults $ \(num, name, time) -> do
      let padding = replicate (maxNameLength - length name) ' '
      printf "%11d | %s%s | %15.15fs\n" num name padding time

runner :: Maybe Int -> Int -> Test -> IO (Int, String, Double)
runner benchmarkCount testNumber test = do
  avgTime <-
    if isJust benchmarkCount
      then do
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
        let avgTime = sum times / fromIntegral count
        putStrLn $ "Benchmark result: " ++ show avgTime ++ " seconds\n"
        return avgTime
      else return 0
  return (testNumber, testName test, avgTime)

testName :: Test -> String
testName (TestLabel name _) = name
testName _ = "Unnamed test"

discardOutput :: PutText Int
discardOutput = PutText (\_ _ n -> return (n + 1)) 0

getTests :: Test -> [Test]
getTests (TestList ts) = ts
getTests t = [t]