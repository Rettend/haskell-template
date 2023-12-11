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

## 📜 License

[MIT](LICENSE)
