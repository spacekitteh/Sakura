{-# LANGUAGE GADTs, DataKinds, StandaloneDeriving, DeriveFunctor,DeriveFoldable,DeriveTraversable #-}
module Types.TTT where
  import Numeric.Natural
  import Control.Lens
  import Control.Monad
  newtype BoundVar bind = BoundVar (bind, TT bind)

--  data Binding = NonBinding | Binder
--  data Form = Variable | GroundType | Lit | Misc

  
    
  data PrimType = Int64 | Floating64 deriving (Eq, Ord)

  data TT bind where
    Var :: bind -> TT  bind
    Lam :: bind -> TT bind -> TT bind
    Pi  :: bind -> TT bind -> TT bind
    App :: TT bind -> TT bind -> TT  bind
    GroundType :: PrimType -> TT bind
    Universe :: Natural -> TT bind
  
                              
  deriving instance Eq bind => Eq (TT bind)
  deriving instance Functor (TT)
  deriving instance Foldable (TT)
  deriving instance Traversable (TT)
  deriving instance Generic (TT)

  instance Applicative (TT) where
    pure = Var
    (<*>) = ap

  instance Monad (TT) where
    Var a >>= f = f a
    Lam x e >>= f = Lam (f x) (e >>= f)
 

       
  
