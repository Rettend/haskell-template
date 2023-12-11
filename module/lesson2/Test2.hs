module Module.Lesson2.Test2 where

import Module.Lesson2.Task2
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
  assertEqual "Test your math skills" 0 (doMath (+) 1 2)