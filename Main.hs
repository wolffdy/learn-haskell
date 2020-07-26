module Main where

import Log

main :: IO ()
main = putStrLn "Hello, Haskell!"

toDigitsRev :: Integer -> [Integer]
toDigitsRev 0 = [0]
toDigitsRev i = toDigitsRevRec i

toDigitsRevRec :: Integer -> [Integer]
toDigitsRevRec 0 = []
toDigitsRevRec i = let car = i `mod` 10 in
             let dividend = i `div` 10 in
             car:toDigitsRevRec dividend

toDigits :: Integer -> [Integer]
toDigits 0 = [0]
toDigits i = toDigitsRec i

toDigitsRec :: Integer -> [Integer]
toDigitsRec 0 = []
toDigitsRec i = let car = i `mod` 10 in
             let dividend = i `div` 10 in
             (toDigitsRec dividend) ++ [car]

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther vec = let fr = \c -> \(even, acc) -> if even then (not even, (2*c):acc) else (not even, c:acc) in
                        snd $ foldr fr (False, []) vec

sumDigits :: [Integer] -> Integer
sumDigits digs = sum $ digs >>= toDigits

validate :: Integer -> Bool
validate x = (== 0) $ flip mod 10 $ sumDigits $ doubleEveryOther $ toDigits x

type Peg = String
type Move = (Peg, Peg)
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 1 a b _ = [(a, b)]
hanoi n a b c = hanoi (n - 1) a c b
            ++ hanoi 1 a b c
            ++ hanoi (n - 1) c b a
