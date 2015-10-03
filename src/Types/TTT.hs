{-# LANGUAGE GADTs, DataKinds, StandaloneDeriving, RankNTypes, FlexibleContexts, TemplateHaskell, TypeOperators, DeriveFunctor,DeriveFoldable,DeriveTraversable, DeriveGeneric, FlexibleInstances, PolyKinds #-}
module Types.TTT where
  import Numeric.Natural
  import Data.Maybe
  import Control.Lens
  import Control.Monad
  import Data.Comp hiding (Hole)
  import Data.Comp.Show
  import Data.Comp.Ops
  import Data.Comp.Equality
  import Data.Comp.Ordering
  import Data.Comp.Derive

    
  data PrimType = Int64 | Floating64 deriving (Eq, Ord)

  data Variable a = Var String a deriving (Eq, Ord, Functor, Foldable, Traversable)
  instance Show a => Show (Variable a) where
    show (Var x t) = show x ++ ":" ++ show t

  data CoreTT a where
    App :: a  -> a -> CoreTT a 
    Universe :: Natural -> CoreTT a
    Variable :: Variable a -> CoreTT a
    Bind :: Binder a -> a -> CoreTT a


  deriving instance Show a => Show (CoreTT a)
  data Binder a = Lam (Variable a) | Pi (Variable a) | Let (Variable a) a deriving (Eq, Ord, Show, Functor, Foldable, Traversable)


  data DevTT a where
    Hole :: Variable a  -> DevTT a 

  data OptTT a  where
    SSEVect :: a  -> OptTT a

  type Foo = DevTT :+: CoreTT :+: OptTT
  makePrisms ''CoreTT
  $(derive [smartConstructors, smartAConstructors] [''Variable, ''Binder])

  $(derive [makeFunctor, makeFoldable, makeTraversable, makeShowF, smartConstructors, smartAConstructors, makeEqF, makeOrdF] 
         [ ''CoreTT, ''OptTT,   ''DevTT])

  deriving instance Applicative (CoreTT) where


  --snooty = prism' iApp fgs where


  fgs :: forall f g . (f :<: g) => Term g -> Maybe (f (Term g))
  fgs x= proj (unTerm x)


  b :: Term Foo
  b = iApp (iUniverse 2) (iUniverse 3)

  appGet  ::Term Foo ->  Maybe (CoreTT (Term Foo))
  appGet = (asAppTuple . fgs)  where
    asAppTuple (Just (App a b)) = Just (a,b)
    asAppTuple _ = Nothing

  appSet :: forall f a. (CoreTT :<: f) => (Term f, Term f) -> Term f
  appSet (a,b) = iApp a b

  thePrism = prism' appSet appGet
