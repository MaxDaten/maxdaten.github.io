--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
import           Data.Monoid (mappend)
import           Hakyll as Hakyll
import           Data.Time
import           Data.Maybe (fromMaybe)
import           System.Environment

--------------------------------------------------------------------------------
main :: IO ()
main = do
    putStrLn "Hello cv.maxdaten.io"
    now <- getCurrentTime
    config <- siteGeneratorConfiguration
    hakyllWith config $ do
        match "index.html" $ do
            route idRoute
            compile copyFileCompiler


siteGeneratorConfiguration :: IO Hakyll.Configuration
siteGeneratorConfiguration = do
    let config@Hakyll.Configuration{..} = defaultConfiguration
    providerDirectory <- fromMaybe providerDirectory <$> lookupEnv "SITE_SOURCE_DIRECTORY"
    return Hakyll.Configuration{..}
