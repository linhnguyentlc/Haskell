{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_Pong (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/linhln/Dev/Haskell/Gloss/Pong/.cabal-sandbox/bin"
libdir     = "/Users/linhln/Dev/Haskell/Gloss/Pong/.cabal-sandbox/lib/x86_64-osx-ghc-8.0.1/Pong-0.1.0.0"
datadir    = "/Users/linhln/Dev/Haskell/Gloss/Pong/.cabal-sandbox/share/x86_64-osx-ghc-8.0.1/Pong-0.1.0.0"
libexecdir = "/Users/linhln/Dev/Haskell/Gloss/Pong/.cabal-sandbox/libexec"
sysconfdir = "/Users/linhln/Dev/Haskell/Gloss/Pong/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Pong_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Pong_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Pong_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Pong_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Pong_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
