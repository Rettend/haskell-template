import Task1
import Test.HUnit (Test (..), assertEqual)
import TestUtils (run)

main :: IO ()
main = do
  run tests

tests :: Test
tests =
  TestList
    [ TestLabel "Test for composeAll function" testComposeAll,
      TestLabel "Test for flabbergast function" testFlabbergast
    ]

testComposeAll :: Test
testComposeAll = TestCase $ do
  assertEqual "Test for [1, 2, 3] and 3" 729 (composeAll [(^ 1), (^ 2), (^ 3)] 3)
  assertEqual "Test for [1, 2, 3] and 4" 4096 (composeAll [(^ 1), (^ 2), (^ 3)] 4)
  assertEqual "Test for [1, 2, 3] and 5" 15625 (composeAll [(^ 1), (^ 2), (^ 3)] 5)
  assertEqual "Test for [1, 2, 3] and 6" 46656 (composeAll [(^ 1), (^ 2), (^ 3)] 6)
  assertEqual "Test for [1, 2, 3] and 7" 117649 (composeAll [(^ 1), (^ 2), (^ 3)] 7)
  assertEqual "Test for [1, 2, 3] and 8" 262144 (composeAll [(^ 1), (^ 2), (^ 3)] 8)
  assertEqual "Test for [1, 2, 3] and 9" 531441 (composeAll [(^ 1), (^ 2), (^ 3)] 9)
  assertEqual "Test for [1, 2, 3] and 10" 1000000 (composeAll [(^ 1), (^ 2), (^ 3)] 10)
  assertEqual "Test for [1, 2, 3] and 11" 1977326743 (composeAll [(^ 1), (^ 2), (^ 3)] 11)
  assertEqual "Test for [1, 2, 3] and 12" 13841287201 (composeAll [(^ 1), (^ 2), (^ 3)] 12)
  assertEqual "Test for [1, 2, 3] and 13" 96889010407 (composeAll [(^ 1), (^ 2), (^ 3)] 13)
  assertEqual "Test for [1, 2, 3] and 14" 678223072849 (composeAll [(^ 1), (^ 2), (^ 3)] 14)

testFlabbergast :: Test
testFlabbergast = TestCase $ do
  assertEqual "Test for (tail, 3) and [1, 2, 3, 4, 5]" [4, 5] (flabbergast (tail, 3) [1, 2, 3, 4, 5])
  assertEqual "Test for (map (^ 2), 10) and [1, 2, 3]" [1, 179769313486231590772930519078902473361797697894230657273430081157732675805500963132708477322407536021120113879871393357658789768814416622492847430639474124377767893424865485276302219601246094119453082952085005768838150682342462881473913110540827237163350510684586298239947245938479716304835356329624224137216, 373391848741020043532959754184866588225409776783734007750636931722079040617265251229993688938803977220468765065431475158108727054592160858581351336982809187314191748594262580938807019951956404285571818041046681288797402925517668012340617298396574731619152386723046235125934896058590588284654793540505936202376547807442730582144527058988756251452817793413352141920744623027518729185432862375737063985485319476416926263819972887006907013899256524297198527698749274196276811060702333710356481] (flabbergast (map (^ 2), 10) [1, 2, 3])
