module Main where

import Data.ByteString (ByteString)
import Data.Text (Text)
import LLVM.Context (Context, withContext)
import LLVM.Module (Module, moduleLLVMAssembly, withModuleFromAST)
import Prelude
import System.Process
import Test.Hspec hiding (context, example)

import qualified Data.ByteString as BS
import qualified Data.Text as T
import qualified Example
import qualified LLVM.AST as AST
import qualified Text.Show.Pretty

main :: IO ()
main =
  hspec spec

spec :: Spec
spec = do
  describe "hello-world" $ do
    it "in LLVM" $
      "handwritten/hello-world.ll" `evaluatesTo` "hello world\n"
    it "Haskell -> LLVM" $
      compileAndEvaluate Example.helloWorld "hello-world" "hello world\n"

  describe "functions" $ do
    it "in LLVM" $
      "handwritten/functions.ll" `evaluatesTo` "5\n"
    it "Haskell -> LLVM" $
      compileAndEvaluate Example.functions "functions" "5\n"

  describe "branching" $ do
    it "in LLVM" $
      "handwritten/branching.ll" `evaluatesTo` "6\n"
    it "Haskell -> LLVM" $
      compileAndEvaluate Example.branching "branching" "6\n"

generateLlvm :: AST.Module -> IO ByteString
generateLlvm llvmModule =
  withContext f
  where
    f :: Context -> IO ByteString
    f context =
      withModuleFromAST context llvmModule g

    g :: Module -> IO ByteString
    g m =
      moduleLLVMAssembly m

evaluatesTo :: [Char] -> Text -> IO ()
evaluatesTo path expected = do
  res <- readProcess "lli-7" [path] mempty
  T.pack res `shouldBe` expected

compileAndEvaluate :: AST.Module -> [Char] -> Text -> IO ()
compileAndEvaluate example filename expected = do

  -- Write the data structure we've created to a file for examination.
  --
  -- (It will be pretty large, and is meant to show how painful it
  -- would be to create directly if we didn't have IRBuilder).
  writeFile ("generated/" <> filename <> ".hs") (Text.Show.Pretty.ppShow example)

  -- Write out the .ll file
  BS.writeFile path =<< generateLlvm example

  -- Evaluate the .ll file
  path `evaluatesTo` expected

  -- Compile the .ll file to .s (for aSsembly)
  _ <- readProcess "llc-7" [path] mempty

  -- Compile the .s file to .native (excluded from the repo by .gitignore)
  _ <- readProcess "clang" [path, "-o", machineCodePath, "-Wno-override-module"] mempty

  -- Ensure that the machine code also executes correctly
  res <- readProcess machineCodePath [] mempty
  T.pack res `shouldBe` expected

  where
    path :: [Char]
    path =
      "generated/" <> filename <> ".ll"

    machineCodePath :: [Char]
    machineCodePath =
      "generated/" <> filename <> ".native"
