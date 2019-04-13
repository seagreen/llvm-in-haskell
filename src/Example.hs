{-# LANGUAGE RecursiveDo #-}

module Example where

import LLVM.AST.Type (i64, i8, ptr)
import LLVM.IRBuilder.Instruction (add, br, call, condBr, globalStringPtr, icmp, phi, ret)
import LLVM.IRBuilder.Module (ModuleBuilder, buildModule, externVarArgs, function)
import LLVM.IRBuilder.Monad (IRBuilderT, block, named)
import Prelude

import qualified LLVM.AST as AST
import qualified LLVM.AST.Constant as C
import qualified LLVM.AST.IntegerPredicate as IntegerPredicate

helloWorld :: AST.Module
helloWorld =
  buildModule "Main" f
  where
    f :: ModuleBuilder ()
    f = do
      printf <- externVarArgs "printf" [ptr i8] i64
      _ <- function "main" mempty i64 (\_ -> mainBody printf)
      pure ()

    mainBody :: AST.Operand -> IRBuilderT ModuleBuilder ()
    mainBody printf = do
      fmt <- globalStringPtr "%s\n" "fmt"
      hello <- globalStringPtr "hello world" "hello"
      _ <- call printf [(fmt, mempty), (hello, mempty)]

      ret (constant 0) -- For 'constant' see the helper function below

functions :: AST.Module
functions =
  buildModule "Main" f
  where
    f :: ModuleBuilder ()
    f = do
      printf <- externVarArgs "printf" [ptr i8] i64

      double <- function "double" [(i64, "n")] i64 $ \[n] -> do
                  ret =<< add n n

      plusOne <- function "plus_one" [(i64, "n")] i64 $ \[n] -> do
                   ret =<< add n (constant 1)

      _ <- function "main" mempty i64 $ \_ -> do
             res1 <- call double [(constant 2, mempty)]
             res2 <- call plusOne [(res1, mempty)]

             fmt <- globalStringPtr "%d\n" "fmt"
             _ <- call printf [(fmt, mempty), (res2, mempty)]

             ret (constant 0)

      pure ()

branching :: AST.Module
branching =
  buildModule "Main" f
  where
    f :: ModuleBuilder ()
    f = do
      printf <- externVarArgs "printf" [ptr i8] i64

      _ <- function "main" mempty i64 $ \_ -> mdo
             _ <- named block "Entry"
             test <- icmp IntegerPredicate.EQ (constant 1) (constant 2)
             condBr test ifEqual ifUnequal

             ifEqual <- named block "IfEqual"
             res1 <- add (constant 2) (constant 2)
             br end

             ifUnequal <- named block "IfUnequal"
             res2 <- add (constant 3) (constant 3)
             br end

             end <- named block "End"
             res3 <- phi [(res1, ifEqual), (res2, ifUnequal)]
             fmt <- globalStringPtr "%d\n" "fmt"
             _ <- call printf [(fmt, mempty), (res3, mempty)]
             ret (constant 0)

      pure ()

-- | Helper function.
constant :: Integer -> AST.Operand
constant n =
  AST.ConstantOperand (C.Int 64 n)
