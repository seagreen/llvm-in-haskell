Module
  { moduleName = "Main"
  , moduleSourceFileName = "<string>"
  , moduleDataLayout = Nothing
  , moduleTargetTriple = Nothing
  , moduleDefinitions =
      [ GlobalDefinition
          Function
            { linkage = External
            , visibility = Default
            , dllStorageClass = Nothing
            , callingConvention = C
            , returnAttributes = []
            , returnType = IntegerType { typeBits = 64 }
            , name = Name "printf"
            , parameters =
                ( [ Parameter
                      PointerType
                        { pointerReferent = IntegerType { typeBits = 8 }
                        , pointerAddrSpace = AddrSpace 0
                        }
                      (Name "")
                      []
                  ]
                , True
                )
            , functionAttributes = []
            , section = Nothing
            , comdat = Nothing
            , alignment = 0
            , garbageCollectorName = Nothing
            , prefix = Nothing
            , basicBlocks = []
            , personalityFunction = Nothing
            , metadata = []
            }
      , GlobalDefinition
          Function
            { linkage = External
            , visibility = Default
            , dllStorageClass = Nothing
            , callingConvention = C
            , returnAttributes = []
            , returnType = IntegerType { typeBits = 64 }
            , name = Name "double"
            , parameters =
                ( [ Parameter IntegerType { typeBits = 64 } (Name "n") [] ]
                , False
                )
            , functionAttributes = []
            , section = Nothing
            , comdat = Nothing
            , alignment = 0
            , garbageCollectorName = Nothing
            , prefix = Nothing
            , basicBlocks =
                [ BasicBlock
                    (UnName 0)
                    [ UnName 1 :=
                        Add
                          { nsw = False
                          , nuw = False
                          , operand0 =
                              LocalReference IntegerType { typeBits = 64 } (Name "n")
                          , operand1 =
                              LocalReference IntegerType { typeBits = 64 } (Name "n")
                          , metadata = []
                          }
                    ]
                    (Do
                       Ret
                         { returnOperand =
                             Just (LocalReference IntegerType { typeBits = 64 } (UnName 1))
                         , metadata' = []
                         })
                ]
            , personalityFunction = Nothing
            , metadata = []
            }
      , GlobalDefinition
          Function
            { linkage = External
            , visibility = Default
            , dllStorageClass = Nothing
            , callingConvention = C
            , returnAttributes = []
            , returnType = IntegerType { typeBits = 64 }
            , name = Name "plus_one"
            , parameters =
                ( [ Parameter IntegerType { typeBits = 64 } (Name "n") [] ]
                , False
                )
            , functionAttributes = []
            , section = Nothing
            , comdat = Nothing
            , alignment = 0
            , garbageCollectorName = Nothing
            , prefix = Nothing
            , basicBlocks =
                [ BasicBlock
                    (UnName 0)
                    [ UnName 1 :=
                        Add
                          { nsw = False
                          , nuw = False
                          , operand0 =
                              LocalReference IntegerType { typeBits = 64 } (Name "n")
                          , operand1 =
                              ConstantOperand Int { integerBits = 64 , integerValue = 1 }
                          , metadata = []
                          }
                    ]
                    (Do
                       Ret
                         { returnOperand =
                             Just (LocalReference IntegerType { typeBits = 64 } (UnName 1))
                         , metadata' = []
                         })
                ]
            , personalityFunction = Nothing
            , metadata = []
            }
      , GlobalDefinition
          GlobalVariable
            { name = Name "fmt"
            , linkage = External
            , visibility = Default
            , dllStorageClass = Nothing
            , threadLocalMode = Nothing
            , unnamedAddr = Just GlobalAddr
            , isConstant = True
            , type' =
                ArrayType
                  { nArrayElements = 4 , elementType = IntegerType { typeBits = 8 } }
            , addrSpace = AddrSpace 0
            , initializer =
                Just
                  Array
                    { memberType = IntegerType { typeBits = 8 }
                    , memberValues =
                        [ Int { integerBits = 8 , integerValue = 37 }
                        , Int { integerBits = 8 , integerValue = 100 }
                        , Int { integerBits = 8 , integerValue = 10 }
                        , Int { integerBits = 8 , integerValue = 0 }
                        ]
                    }
            , section = Nothing
            , comdat = Nothing
            , alignment = 0
            , metadata = []
            }
      , GlobalDefinition
          Function
            { linkage = External
            , visibility = Default
            , dllStorageClass = Nothing
            , callingConvention = C
            , returnAttributes = []
            , returnType = IntegerType { typeBits = 64 }
            , name = Name "main"
            , parameters = ( [] , False )
            , functionAttributes = []
            , section = Nothing
            , comdat = Nothing
            , alignment = 0
            , garbageCollectorName = Nothing
            , prefix = Nothing
            , basicBlocks =
                [ BasicBlock
                    (UnName 0)
                    [ UnName 1 :=
                        Call
                          { tailCallKind = Nothing
                          , callingConvention = C
                          , returnAttributes = []
                          , function =
                              Right
                                (ConstantOperand
                                   (GlobalReference
                                      PointerType
                                        { pointerReferent =
                                            FunctionType
                                              { resultType = IntegerType { typeBits = 64 }
                                              , argumentTypes = [ IntegerType { typeBits = 64 } ]
                                              , isVarArg = False
                                              }
                                        , pointerAddrSpace = AddrSpace 0
                                        }
                                      (Name "double")))
                          , arguments =
                              [ ( ConstantOperand Int { integerBits = 64 , integerValue = 2 }
                                , []
                                )
                              ]
                          , functionAttributes = []
                          , metadata = []
                          }
                    , UnName 2 :=
                        Call
                          { tailCallKind = Nothing
                          , callingConvention = C
                          , returnAttributes = []
                          , function =
                              Right
                                (ConstantOperand
                                   (GlobalReference
                                      PointerType
                                        { pointerReferent =
                                            FunctionType
                                              { resultType = IntegerType { typeBits = 64 }
                                              , argumentTypes = [ IntegerType { typeBits = 64 } ]
                                              , isVarArg = False
                                              }
                                        , pointerAddrSpace = AddrSpace 0
                                        }
                                      (Name "plus_one")))
                          , arguments =
                              [ ( LocalReference IntegerType { typeBits = 64 } (UnName 1) , [] )
                              ]
                          , functionAttributes = []
                          , metadata = []
                          }
                    , UnName 3 :=
                        GetElementPtr
                          { inBounds = True
                          , address =
                              ConstantOperand
                                (GlobalReference
                                   PointerType
                                     { pointerReferent =
                                         ArrayType
                                           { nArrayElements = 4
                                           , elementType = IntegerType { typeBits = 8 }
                                           }
                                     , pointerAddrSpace = AddrSpace 0
                                     }
                                   (Name "fmt"))
                          , indices =
                              [ ConstantOperand Int { integerBits = 32 , integerValue = 0 }
                              , ConstantOperand Int { integerBits = 32 , integerValue = 0 }
                              ]
                          , metadata = []
                          }
                    , UnName 4 :=
                        Call
                          { tailCallKind = Nothing
                          , callingConvention = C
                          , returnAttributes = []
                          , function =
                              Right
                                (ConstantOperand
                                   (GlobalReference
                                      PointerType
                                        { pointerReferent =
                                            FunctionType
                                              { resultType = IntegerType { typeBits = 64 }
                                              , argumentTypes =
                                                  [ PointerType
                                                      { pointerReferent =
                                                          IntegerType { typeBits = 8 }
                                                      , pointerAddrSpace = AddrSpace 0
                                                      }
                                                  ]
                                              , isVarArg = True
                                              }
                                        , pointerAddrSpace = AddrSpace 0
                                        }
                                      (Name "printf")))
                          , arguments =
                              [ ( LocalReference
                                    PointerType
                                      { pointerReferent = IntegerType { typeBits = 8 }
                                      , pointerAddrSpace = AddrSpace 0
                                      }
                                    (UnName 3)
                                , []
                                )
                              , ( LocalReference IntegerType { typeBits = 64 } (UnName 2) , [] )
                              ]
                          , functionAttributes = []
                          , metadata = []
                          }
                    ]
                    (Do
                       Ret
                         { returnOperand =
                             Just (ConstantOperand Int { integerBits = 64 , integerValue = 0 })
                         , metadata' = []
                         })
                ]
            , personalityFunction = Nothing
            , metadata = []
            }
      ]
  }