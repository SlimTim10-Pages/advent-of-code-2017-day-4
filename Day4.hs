{-# LANGUAGE EmptyDataDecls #-}

module Day4 where

import FFI
import Prelude

main :: Fay ()
main = do
  addWindowEvent "load" run

run :: Fay ()
run = do
  part1Button <- getElementById "part1"
  part2Button <- getElementById "part2"
  addEventListener part1Button "click" part1
  addEventListener part2Button "click" part2

part1 :: Fay ()
part1 = do
  inputNode <- select "#input"
  outputNode <- select "#output"
  input <- getVal inputNode
  let xs = lines input
  let result = show . validPassphrases $ xs
  setHTML result outputNode
  return ()

part2 :: Fay ()
part2 = do
  return ()

anyDuplicates :: Eq a => [a] -> Bool
anyDuplicates [] = False
anyDuplicates [_] = False
anyDuplicates (x:xs)
  | x `elem` xs = True
  | otherwise = anyDuplicates xs

passphraseCheck :: String -> Bool
passphraseCheck passphrase =
  let ws = words passphrase
  in (length ws > 1) && (not . anyDuplicates $ ws)

validPassphrases :: [String] -> Int
validPassphrases = length . filter (== True) . map passphraseCheck

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
