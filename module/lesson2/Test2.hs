import Task2
import Test.HUnit (Test (..), assertEqual)
import TestUtils (run)

main :: IO ()
main = do
  run tests

tests :: Test
tests =
  TestList
    []