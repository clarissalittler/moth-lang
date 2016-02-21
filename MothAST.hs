module MothAST where

type VName = String
type Label = String
type OpName = String

data Typ = TVar VName
         | TBool
         | TFun [Typ] Typ
         | TNum Float
         | TUndefined
         | TObj [(Label,Typ)]

data MothExp = MVar VName
             | MVarDecl VName Typ MothExp
             | MApp MothExp [MothExp]
             | MLam [(VName,Typ)] [MothStmt]
             | MTypeOf MothExp
             | MBinOp OpName
             | MUnOp OpName
             | MThis
             | MObjLit [(Label, MothExp)]
             | MDot MothExp Label
             | MPrint
             | MRead
-- I'm thinking of leaving out new syntax             

data MothStmt = MExp MothExp
              | MFor MothExp MothExp MothExp [MothStmt]
              | MWhile MothExp [MothStmt]
              | MReturn MothExp
              | MIf MothExp [MothStmt] [(MothExp,[MothStmt])] [MothStmt]

type MothProg = [MothStmt]


