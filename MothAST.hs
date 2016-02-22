module MothAST where

import Control.Monad.Reader

type VName = String
type Label = String
type OpName = String

data Typ = TVar VName
         | TBool
         | TFun [Typ] Typ
         | TNum
         | TUndefined
         | TObj [(Label,Typ)]
         | TString

data MothExp = MVar VName
             | MVarDecl VName Typ MothExp
             | MApp MothExp [MothExp]
             | MLam [(VName,Typ)] Typ [MothStmt] MothExp
               -- last MothExp is the return of the function
               -- we're going to be a bit strict and make you 
             | MTypeOf MothExp
             | MBinOp OpName
             | MUnOp OpName
             | MThis
             | MObjLit [(Label, MothExp)]
             | MDot MothExp Label
             | MPrint MothExp
             | MRead
             | MStringLit String
             | MNumLit Float
             | MUndefined
-- I'm thinking of leaving out 'new' syntax for making objects
-- we can just avoid prototyping and all of that in a first teaching language

data MothStmt = MExp MothExp
              | MFor MothExp MothExp MothExp [MothStmt]
              | MWhile MothExp [MothStmt]
              | MIf MothExp [MothStmt] [(MothExp,[MothStmt])] [MothStmt]

type MothProg = [MothStmt]

data CheckData = CD {vars :: [(VName,Typ)],
                     ctxt :: [[(Label,Typ)]]}

type Check = Reader [(VName,Typ)]

lookupM :: MonadReader m [(VName,Typ)] => VName -> m (Maybe Typ)
lookupM = asks . lookup

checkExp :: MothExp -> Check Typ
checkExp (MVar v) = do
  mt <- lookupM v
  case mt of 
    Nothing -> error "variable not defined"
    -- obviously we want better errors later, I'm thinking something that will print out in a nice format
    -- all the variables that exist in scope at the time
    Just t -> return t
checkExp (MApp f es) = do
  ft <- checkExp f
  ts <- mapM checkExp es
  case ft of
    TFun ts' tr -> if ts == ts' 
                   then return r
                   else error "type mismatch in function"
    _ -> error "tried to apply not a function"
checkExp (MTypeOf m) = do
  checkExp m
  return TString
checkExp (MObjLit ls) = do
  ts <- mapM (\ (l,e) -> do
                t <- checkExp e
                return (l,t)) ls
  return $ TObj ts
checkExp (MStringLit _) = return TString
checkExp (MNumLit _) = return TNum
checkExp (MPrint me) = checkExp me >> return TUndefined
checkExp MRead = return TString
checkExp (MDot me l) = do
  t <- checkExp me
  case t of
    TObj ts -> case lookup l t of
                 Nothing -> error "label doesn't exist"
                 Just t' -> return t'
    _ -> error "using dot notation at non-object type"
checkExp 

checkStmt :: MothStmt -> Check ()
checkStmt (MExp m) = checkExp m >> return ()
checkStmt (MFor m1 m2 m3 ms) = do
  t <- checkExp m1
  case t of
    TNum -> do
           checkExp m2
           checkExp m3
           mapM_ checkStmt ms
    _ -> error "not using a number as the index in a for loop"
-- this isn't quite right but it's a start
checkStmt (MWhile me ms) = do
  t <- checkExp me
  case t of
    TBool -> mapM_ checkStmt ms
    _ -> error "not using a boolean for the condition in while"
checkStmt (MIf me mthens mifelses melses) = do
  b <- checkExp me
  if b 
  then do
    mapM_ checkStmt mthens
  else do
    
      
checkAux :: MothExp -> [MothStmt] -> 
