# haskell-template

## 📦 Install

Dependencies:

- HUnit
- tabular

> [!IMPORTANT]  
> Install the dependencies using `cabal install`

```bash
cabal install HUnit
```

## 📖 Usage

```bash
runhaskell module/lesson1/test1.hs <test numbers>
```

All arguments are optional

Flags:

- `-b [iterations]`: Run benchmarks for [iterations] iterations, default is 1
- `-s`: Show summary table where tests are ordered by execution time (slowest first)

## 📚 Examples

Run all tests

```bash
runhaskell module/lesson1/test1.hs
```

Run all tests with benchmarks for 1000000 iterations

```bash
runhaskell module/lesson1/test1.hs -b 1000000
```

Run the first and third tests with benchmarks for 1000000 iterations and show summary table

```bash
runhaskell module/lesson1/test1.hs 1 3 -b 1000000 -s
```

> [!TIP]
> Haskell is actually pretty fast, use millions of iterations or you'll get 0.0s

## 📁 Submodule version

The Submodule version can be found in the **Submodule** branch.
It can be used like this:

```hs
import Submodule.Utils.Test (run)
```

Add it as a submodule to your project:

```bash
git submodule add -b submodule https://github.com/Rettend/haskell-template.git submodule
```

## 📜 License

[MIT](LICENSE)
