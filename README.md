# About

Examples of how to generate LLVM in Haskell with the libraries [llvm-hs](https://hackage.haskell.org/package/llvm-hs) and [llvm-hs-pure](https://hackage.haskell.org/package/llvm-hs-pure).

Meant to complement the more official [llvm-hs-examples](https://github.com/llvm-hs/llvm-hs-examples).

# Walkthrough

Each example is presented in different formats.

1. **Handwritten**

    E.g. [./handwritten/hello-world.ll](./handwritten/hello-world.ll)

    Before trying to generate LLVM using a particular feature using Haskell, it helps to write it once manually.

2. **Haskell**

    E.g. [./src/Example.hs](./src/Example.hs) (then see the definition for `helloWorld`).

    Code using *llvm-hs-pure*'s nice EDSL. Generates everything below.

3. **Haskell data**

    E.g. [./generated/hello-world.hs](./generated/hello-world.hs)

    Pretty printed data structure created by the previous step. You wouldn't want to write this by hand!

4. **Generated LLVM**

    E.g. [./generated/hello-world.ll](./generated/hello-world.ll)

5. **Assembly**

    E.g. [./generated/hello-world.s](./generated/hello-world.s)

6. **Machine code**

    E.g. `./generated/hello-world.native`

    Excluded from the repo by `.gitignore`, but you can see it if you regenerate the examples yourself.

# Install and Regenerate

System dependencies (on Ubuntu):
```sh
sudo apt install llvm-7
sudo apt install clang
```

Regenerate examples:
```sh
stack build --fast --file-watch --test
```
