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
                    (Name "Entry")
                    [ UnName 0 :=
                        ICmp
                          { iPredicate = EQ
                          , operand0 =
                              ConstantOperand Int { integerBits = 64 , integerValue = 1 }
                          , operand1 =
                              ConstantOperand Int { integerBits = 64 , integerValue = 2 }
                          , metadata = []
                          }
                    ]
                    (Do
                       CondBr
                         { condition =
                             LocalReference IntegerType { typeBits = 1 } (UnName 0)
                         , trueDest = Name "IfEqual"
                         , falseDest = Name "IfUnequal"
                         , metadata' = []
                         })
                , BasicBlock
                    (Name "IfEqual")
                    [ UnName 1 :=
                        Add
                          { nsw = False
                          , nuw = False
                          , operand0 =
                              ConstantOperand Int { integerBits = 64 , integerValue = 2 }
                          , operand1 =
                              ConstantOperand Int { integerBits = 64 , integerValue = 2 }
                          , metadata = []
                          }
                    ]
                    (Do Br { dest = Name "End" , metadata' = [] })
                , BasicBlock
                    (Name "IfUnequal")
                    [ UnName 2 :=
                        Add
                          { nsw = False
                          , nuw = False
                          , operand0 =
                              ConstantOperand Int { integerBits = 64 , integerValue = 3 }
                          , operand1 =
                              ConstantOperand Int { integerBits = 64 , integerValue = 3 }
                          , metadata = []
                          }
                    ]
                    (Do Br { dest = Name "End" , metadata' = [] })
                , BasicBlock
                    (Name "End")
                    [ UnName 3 :=
                        Phi
                          { type' = IntegerType { typeBits = 64 }
                          , incomingValues =
                              [ ( LocalReference IntegerType { typeBits = 64 } (UnName 1)
                                , Name "IfEqual"
                                )
                              , ( LocalReference IntegerType { typeBits = 64 } (UnName 2)
                                , Name "IfUnequal"
                                )
                              ]
                          , metadata = []
                          }
                    , UnName 4 :=
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
                    , UnName 5 :=
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
                                    (UnName 4)
                                , []
                                )
                              , ( LocalReference IntegerType { typeBits = 64 } (UnName 3) , [] )
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