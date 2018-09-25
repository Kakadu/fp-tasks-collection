import Data.List

data Lam  = Var String
          | App Lam Lam
          | Abs String Lam
          deriving Show

names :: Lam  -> [String]
names l = helper [] l
  where
    helper acc (Var s) = s:acc
    helper acc (Abs s l) = helper (s:acc) l
    helper acc (App l r) = helper (helper acc r) l

freeVars :: Lam -> [String]
freeVars l = helper [] l
  where
    helper acc (Var s) = s:acc
    helper acc (Abs s l) = acc ++ ((helper [] l) \\ [s])
    helper acc (App l r) = helper (helper acc r) l

nextName :: String -> [String] -> String
nextName s old = helper s old
  where
    helper s old | elem s old = helper ("_" ++ s) old
    helper s _                = s

renameTerm :: [String] -> Lam -> Lam
renameTerm names (Var s) = Var $ nextName s names
renameTerm names (Abs s body) = Abs s $ renameTerm (names \\ [s]) body
renameTerm names (App l r)  = App (renameTerm names l) (renameTerm names r)

subst :: (String,Lam) -> Lam -> Lam
subst (v,what) where_ =
  helper w2
  where
    ns1 = nub $ names what
    w2  = renameTerm ns1 where_
    helper (Var s) | s == v = what
    helper (App l r) = App (helper l) r
    helper (Abs s r) | s == v = Abs s r
    helper (Abs s r)          = Abs s (helper r)
    helper l = l

eval :: [(String, Lam)] -> Lam -> Maybe Lam
eval env (Var s) = lookup s env >>= eval env
eval env (App a b) =
  eval env a >>= after
  where
    after (Abs s body) = eval env (subst (s,b) body)
    after (Var x) = Nothing
    after (App x y) = Nothing
eval _ r@(Abs _ _) = Just r

main = do
  -- testing substitution
  putStrLn $ show $ subst ("x", Var "z") (Abs "x" (Var "x"))
  putStrLn $ show $ subst ("x", Var "z") (Abs "y" (Var "x"))
  -- testing evaluation strategy
  putStrLn $ show $ eval [] $
     Abs "x" $ Abs "y" (Var "x")
  putStrLn $ show $ eval [] $
    App (Abs "x" $ Abs "y" (Var "x")) (Var "z")
  return ()
