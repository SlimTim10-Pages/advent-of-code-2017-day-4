{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

import Lucid

page :: Html ()
page =
  doctypehtml_ $ do
  head_ $ do
    title_ "Day 4"
    link_ [rel_ "stylesheet", type_ "text/css", href_ "https://fonts.googleapis.com/css?family=Source+Code+Pro:300&amp;subset=latin,latin-ext"]
    link_ [rel_ "stylesheet", type_ "text/css", href_ "style.css"]
    script_ [type_ "text/javascript", src_ "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"] ""
    script_ [type_ "text/javascript", src_ "app.js"] ""
    script_ [type_ "text/javascript", src_ "native.js"] ""
    meta_ [httpEquiv_ "Content-Type", content_ "text/html; charset=utf-8"]
  body_ $ do
    article_ [id_ "container"] $ do
      section_ [id_ "input-area"] $ do
        p_ [class_ "label"] "Input"
        textarea_ [id_ "input"] ""
      section_ [id_ "buttons"] $ do
        button_ [id_ "part1", class_ "btn"] "Run part 1"
        button_ [id_ "part2", class_ "btn"] "Run part 2"
        button_ [id_ "part1js", class_ "btn"] "Run part 1 (native JS)"
      section_ [id_ "output-area"] $ do
        p_ [class_ "label"] "Output"
        p_ [id_ "output"] ""
    article_ [id_ "description"] $ do
      toHtmlRaw part1Desc
      toHtmlRaw part2Desc

main :: IO ()
main = renderToFile "docs/index.html" page

part1Desc =
  "<h2>--- Day 4: High-Entropy Passphrases ---</h2><p>A new system policy has been put in place that requires all accounts to use a <em>passphrase</em> instead of simply a pass<em>word</em>. A passphrase consists of a series of words (lowercase letters) separated by spaces.</p>\
\ <p>To ensure security, a valid passphrase must contain no duplicate words.</p>\
\ <p>For example:</p>\
\ <ul>\
\ <li><code>aa bb cc dd ee</code> is valid.</li>\
\ <li><code>aa bb cc dd aa</code> is not valid - the word <code>aa</code> appears more than once.</li>\
\ <li><code>aa bb cc dd aaa</code> is valid - <code>aa</code> and <code>aaa</code> count as different words.</li>\
\ </ul>\
\ <p>The system's full passphrase list is available as your puzzle input. <em>How many passphrases are valid?</em></p>"

part2Desc =
  "<h2>--- Part Two ---</h2><p>For added security, <span title=\"Because as everyone knows, the number of rules is proportional to the level of security.\">yet another system policy</span> has been put in place.  Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase.</p>\
\ <p>For example:</p>\
\ <ul>\
\ <li><code>abcde fghij</code> is a valid passphrase.</li>\
\ <li><code>abcde xyz ecdab</code> is not valid - the letters from the third word can be rearranged to form the first word.</li>\
\ <li><code>a ab abc abd abf abj</code> is a valid passphrase, because <em>all</em> letters need to be used when forming another word.</li>\
\ <li><code>iiii oiii ooii oooi oooo</code> is valid.</li>\
\ <li><code>oiii ioii iioi iiio</code> is not valid - any of these words can be rearranged to form any other word.</li>\
\ </ul>\
\ <p>Under this new system policy, <em>how many passphrases are valid?</em></p>"
