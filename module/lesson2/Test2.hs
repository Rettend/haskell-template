import Task2
import Test.HUnit (Test (..), assertEqual)
import TestUtils (run)

main :: IO ()
main = do
  run tests

tests :: Test
tests =
  TestList [TestLabel "doMath" testDoMath]

testDoMath :: Test
testDoMath = TestCase $ do
  asserEqual "Test your math skills" undefined (doMath (+) 1 2)