{-# LANGUAGE RecursiveDo #-}

module Example where

import LLVM.AST.Type (i64, i8, ptr)
import LLVM.IRBuilder.Instruction (add, br, call, condBr, globalStringPtr, icmp, phi, ret)
import LLVM.IRBuilder.Module (ModuleBuilder, buildModule, externVarArgs, function)
import LLVM.IRBuilder.Monad (IRBuilderT, block, named)
import Prelude

import qualified LLVM.AST as AST
import qualified LLVM.AST.IntegerPredicate as IntegerPredicate
import qualified LLVM.IRBuilder.Constant as IRBuilder.Constant

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

      ret =<< IRBuilder.Constant.int64 0

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
                   one <- IRBuilder.Constant.int64 1
                   ret =<< add n one

      _ <- function "main" mempty i64 $ \_ -> do
             two <- IRBuilder.Constant.int64 2
             res1 <- call double [(two, mempty)]
             res2 <- call plusOne [(res1, mempty)]

             fmt <- globalStringPtr "%d\n" "fmt"
             _ <- call printf [(fmt, mempty), (res2, mempty)]

             ret =<< IRBuilder.Constant.int64 0

      pure ()

branching :: AST.Module
branching =
  buildModule "Main" f
  where
    f :: ModuleBuilder ()
    f = do
      printf <- externVarArgs "printf" [ptr i8] i64

      one <- IRBuilder.Constant.int64 1
      two <- IRBuilder.Constant.int64 2
      three <- IRBuilder.Constant.int64 3

      _ <- function "main" mempty i64 $ \_ -> mdo
             _ <- named block "Entry"
             test <- icmp IntegerPredicate.EQ one two
             condBr test ifEqual ifUnequal

             ifEqual <- named block "IfEqual"
             res1 <- add two two
             br end

             ifUnequal <- named block "IfUnequal"
             res2 <- add three three
             br end

             end <- named block "End"
             res3 <- phi [(res1, ifEqual), (res2, ifUnequal)]
             fmt <- globalStringPtr "%d\n" "fmt"
             _ <- call printf [(fmt, mempty), (res3, mempty)]
             ret =<< IRBuilder.Constant.int64 0

      pure ()
