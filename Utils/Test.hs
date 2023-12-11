module Utils.Test where

import Control.Monad (replicateM, void, when)
import Data.Char (toUpper)
import Data.List (sort)
import Data.Maybe (fromMaybe, isJust, isNothing, listToMaybe, mapMaybe)
import Data.Time.Clock (diffUTCTime, getCurrentTime)
import System.CPUTime (getCPUTime)
import System.Environment (getArgs)
import Test.HUnit (Counts, PutText (..), Test (..), assertBool, assertEqual, runTestTT, runTestText)
import Text.Read (readMaybe)

run :: Test -> IO ()
run tests = do
  args <- getArgs
  let (testArgs, benchmarkArgs) = break (== "-b") args
  let testNumbers = mapMaybe readMaybe testArgs
  let benchmarkCount = if null benchmarkArgs then Nothing else Just (fromMaybe 1 (listToMaybe $ mapMaybe readMaybe (drop 1 benchmarkArgs)))
  if null testNumbers
    then void (runTestTT tests)
    else do
      let selectedTests = [(testNumber, getTests tests !! (testNumber - 1)) | testNumber <- testNumbers, testNumber > 0, testNumber <= length (getTests tests)]
      mapM_ (uncurry (runner benchmarkCount)) selectedTests

runner :: Maybe Int -> Int -> Test -> IO ()
runner benchmarkCount testNumber test = do
  putStrLn $ "Test #" ++ show testNumber
  void (runTestTT test)
  when (isJust benchmarkCount) $ do
    let count = fromMaybe 1 benchmarkCount
    times <- replicateM count $ do
      start <- getCPUTime
      _ <- runTestText discardOutput test
      end <- getCPUTime
      return $ fromIntegral (end - start) / (10 ^ 12)
    putStrLn $ "Benchmark result: " ++ show (sum times / fromIntegral count) ++ " seconds"
  putStrLn ""

discardOutput :: PutText Int
discardOutput = PutText (\_ _ n -> return (n + 1)) 0

getTests :: Test -> [Test]
getTests (TestList ts) = ts
getTests t = [t]
