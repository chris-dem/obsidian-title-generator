module Main (main) where

import Control.Monad (forM_)
import Data.Char (toLower)
import Data.List (intercalate, uncons)
import Data.Time
import System.Environment (getArgs)
import Text.Regex.Posix

extractArguments :: IO (Maybe String)
extractArguments = fmap fst . uncons <$> getArgs

filterNonChars :: String -> String
filterNonChars input = concat (getAllTextMatches (input =~ "[A-Za-z0-9]" :: AllTextMatches [] String))

generateTitle :: Int -> String -> String
generateTitle i = intercalate "-" . (show i :) . fmap (filterNonChars . fmap toLower) . words

getDate :: IO Int
getDate = read . formatTime defaultTimeLocale "%s" <$> getCurrentTime

main :: IO ()
main = do
  i <- getDate
  args <- extractArguments
  forM_ args (putStrLn . generateTitle i)
