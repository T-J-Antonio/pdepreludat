{-# LANGUAGE DataKinds, TypeOperators, UndecidableInstances, FlexibleInstances, ScopedTypeVariables #-}
{-# LANGUAGE NoImplicitPrelude #-}
module PdePreludat (
    (/),
    module Prelude,
    concat,
    length,
    elem,
    sum,
    product,
    null,
    foldr,
    foldr1,
    foldl,
    foldl1,
    maximum,
    minimum,
    all,
    any,
    and,
    or,
    concatMap,
    notElem,
    implementame,
    arreglame,
    (...),
    size
) where 

import Prelude hiding ((/), concat, length, elem, sum, product, null,
                       foldr, foldr1, foldl, foldl1, maximum, minimum,
                       all, any, and, or, concatMap, notElem)
import qualified Prelude as P
import GHC.TypeLits
import Data.Typeable

-- Reemplazos para Foldable
length :: [a] -> Int
length = P.length

concat :: [[a]] -> [a]
concat = P.concat

elem :: Eq a => a -> [a] -> Bool
elem = P.elem

sum :: Num a => [a] -> a
sum = P.sum

product :: Num a => [a] -> a
product = P.product

null ::  [a] -> Bool
null = P.null

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr = P.foldr

foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 = P.foldr1

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl = P.foldl

foldl1 :: (a -> a -> a) -> [a] -> a
foldl1 = P.foldl1

maximum :: Ord a => [a] -> a
maximum = P.maximum

minimum :: Ord a => [a] -> a
minimum = P.minimum

all :: (a -> Bool) -> [a] -> Bool
all = P.all

any :: (a -> Bool) -> [a] -> Bool
any = P.any

and :: [Bool] -> Bool
and = P.and

or :: [Bool] -> Bool
or = P.or

concatMap :: (a -> [b]) -> [a] -> [b]
concatMap = P.concatMap

notElem :: (Eq a) => a -> [a] -> Bool
notElem = P.notElem

-- Show de funciones
instance Show (a -> b) where
    show _ = "<una función>"

class Fractionable a where
    toFractional :: (Fractional b) => a -> b

instance Fractionable Int where
    toFractional entero = fromIntegral entero

instance Fractionable Integer where
    toFractional entero = fromIntegral entero

instance Fractionable Double where
    toFractional = fromRational . toRational

instance Fractionable Float where
    toFractional = fromRational . toRational

(/) :: (Fractionable a, Fractionable b, Fractional c) => a -> b -> c
a / b = toFractional a P./ toFractional b

-- TODO: intentar hacer funcionar esto para filter
-- instance (Typeable a, Typeable b) => Show (a -> b) where
--     show _ = "Una función de tipo: "
--         ++ show (typeOf (undefined :: a)) ++ " -> "
--         ++ show (typeOf (undefined :: b))

-- Custom Type Errors

--- Para funciones

type ErrorNumeroXFuncion = Text "Estás usando una función como un número o un número como una función."
type ErrorOrdenableXFuncion = Text "Las funciones no se pueden ordenar ni comparar."
type ErrorEnumerableXFuncion = Text "Las funciones no son enumerables."

instance TypeError (ErrorNumeroXFuncion) => Num (a -> b)
instance TypeError ErrorOrdenableXFuncion => Ord (a -> b)
instance TypeError ErrorOrdenableXFuncion => Eq (a -> b)
instance TypeError ErrorNumeroXFuncion => Floating (a -> b)
instance TypeError ErrorNumeroXFuncion => Fractional (a -> b)
instance (TypeError ErrorNumeroXFuncion,
          TypeError ErrorEnumerableXFuncion,
          TypeError ErrorOrdenableXFuncion) => Integral (a -> b)
instance (TypeError ErrorNumeroXFuncion, TypeError ErrorOrdenableXFuncion) => RealFrac (a -> b)
instance (TypeError ErrorNumeroXFuncion, TypeError ErrorOrdenableXFuncion) => RealFloat (a -> b)
instance (TypeError ErrorNumeroXFuncion, TypeError ErrorOrdenableXFuncion) => Real (a -> b)
instance (TypeError ErrorEnumerableXFuncion) => Enum (a -> b)
--instance Integral

---Para listas
type ErrorNumeroXLista = Text "Estás usando una lista como un número o un número como una lista."
type ErrorEnumerableXLista = Text "Las listas no son enumerables."

instance TypeError ErrorNumeroXLista => Num [a]
instance TypeError ErrorNumeroXLista => Floating [a]
instance TypeError ErrorNumeroXLista => Fractional [a]
instance (Ord a, TypeError ErrorEnumerableXLista, TypeError ErrorNumeroXLista) => Integral [a]
instance (Ord a, TypeError ErrorNumeroXLista) => RealFrac [a]
instance (Ord a, TypeError ErrorNumeroXLista) => RealFloat [a]
instance (Ord a, TypeError ErrorNumeroXLista) => Real [a]
instance (TypeError ErrorNumeroXLista) => Enum [a]

---Para caracteres
type ErrorNumeroXCaracter = Text "Estás usando una caracter como un número o un número como un caracter."

instance TypeError ErrorNumeroXCaracter => Num Char
instance TypeError ErrorNumeroXCaracter => Floating Char
instance TypeError ErrorNumeroXCaracter => Fractional Char
instance TypeError ErrorNumeroXCaracter => Integral Char
instance TypeError ErrorNumeroXCaracter => RealFrac Char
instance TypeError ErrorNumeroXCaracter => RealFloat Char
instance TypeError ErrorNumeroXCaracter => Real Char

(...) :: a
(...) = error "Falta implementar."

implementame :: a
implementame = (...)

arreglame :: a
arreglame = (...)

size :: [a] -> Int
size = length