module Main (main) where

import Data.Char (toLower)
import Data.List (intercalate)
import Data.Time

extractArguments :: IO String
extractArguments = getLine

generateTitle :: Int -> String -> String
generateTitle i = intercalate "-" . (show i :) . fmap (fmap toLower) . words

getDate :: IO Int
getDate = read . formatTime defaultTimeLocale "%s" <$> getCurrentTime

main :: IO ()
main = do
  i <- getDate
  extractArguments >>= putStrLn . generateTitle i
