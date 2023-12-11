# haskell-template

## 📦 Install

> [!IMPORTANT]  
> HUnit is a required dependency

```bash
cabal install HUnit
```

## 📖 Usage

```bash
runhaskell module/lesson1/test1.hs <test number> [-b] [iterations]
```

All arguments are optional:

- `<test number>`: The test to run by index
- `-b`: Run benchmarks
- `[iterations]`: Number of iterations to run benchmarks

## 📚 Examples

Run all tests

```bash
runhaskell module/lesson1/test1.hs
```

Run all tests with benchmarks for 1000000 iterations

```bash
runhaskell module/lesson1/test1.hs -b 1000000
```

Run specific test with benchmarks for 1000000 iterations

```bash
runhaskell module/lesson1/test1.hs 1 -b 1000000
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
