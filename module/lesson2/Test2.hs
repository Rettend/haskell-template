module Test2 where

import Task2
import Test.HUnit (Test (..), assertEqual)
import Utils.Test (run)

main :: IO ()
main = do
  run tests

tests :: Test
tests =
  TestList [TestLabel "doMath" testDoMath]

testDoMath :: Test
testDoMath = TestCase $ do
  assertEqual "Test your math skills" undefined (doMath (+) 1 2)