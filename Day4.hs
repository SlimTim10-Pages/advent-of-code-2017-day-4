{-# LANGUAGE EmptyDataDecls #-}

module Day4 where

import FFI
import Prelude

main :: Fay ()
main = do
  addWindowEvent "load" load

load :: Fay ()
load = do
  part1Button <- getElementById "part1"
  part2Button <- getElementById "part2"
  addEventListener part1Button "click" (run validPassphrases)
  addEventListener part2Button "click" (run validPassphrases2)

run :: ([String] -> Int) -> Fay ()
run checker = do
  inputNode <- select "#input"
  outputNode <- select "#output"
  input <- getVal inputNode
  let xs = lines input
  let result = show . checker $ xs
  setHTML result outputNode
  return ()

anyDuplicates :: Eq a => [a] -> Bool
anyDuplicates [] = False
anyDuplicates (x:xs)
  | x `elem` xs = True
  | otherwise = anyDuplicates xs

passphraseCheck :: String -> Bool
passphraseCheck passphrase =
  let ws = words passphrase
  in (length ws > 1) && (not . anyDuplicates $ ws)

validPassphrases :: [String] -> Int
validPassphrases = length . filter (== True) . map passphraseCheck

passphraseCheck2 :: String -> Bool
passphraseCheck2 passphrase =
  let ws = map sort . words $ passphrase
  in (length ws > 1) && (not . anyDuplicates $ ws)

validPassphrases2 :: [String] -> Int
validPassphrases2 = length . filter (== True) . map passphraseCheck2

data Element
data Event

getElementById :: String -> Fay Element
getElementById = ffi "document['getElementById'](%1)"

setInnerHTML :: Element -> String -> Fay ()
setInnerHTML = ffi "%1['innerHTML'] = %2"

getInnerHTML :: Element -> Fay String
getInnerHTML = ffi "%1['innerHTML']"

addWindowEvent :: String -> Fay () -> Fay ()
addWindowEvent = ffi "window['addEventListener'](%1, %2)"

addEventListener :: Element -> String -> Fay () -> Fay ()
addEventListener = ffi "%1['addEventListener'](%2, %3)"

data JQuery
instance Show JQuery

getVal :: JQuery -> Fay String
getVal = ffi "%1['val']()"

setVal :: String -> JQuery -> Fay JQuery
setVal = ffi "%2['val'](%1)"

setHTML :: String -> JQuery -> Fay JQuery
setHTML = ffi "%2['html'](%1)"

select :: String -> Fay JQuery
select = ffi "window['jQuery'](%1)"
