{-# LANGUAGE OverloadedStrings, RecordWildCards, ViewPatterns, LambdaCase #-}
module Main where

import Protolude
import Network.IRC.Client

channel = "#augsburg"

main :: IO ()
main = do
  conn <- connect "chat.freenode.net" 6667 3
  start (conn { _logfunc = stdoutLogger })
        $ (defaultIRCConf "stackenblocken")
            { _eventHandlers = defaultEventHandlers <> [ joinAugsburg, pingLabping ] }

joinAugsburg = EventHandler
  { _description = "join " <> channel
  , _matchType = ENumeric
  , _eventFunc = \ev -> case _message ev of
      Numeric 1 _ -> send $ Join channel
      _ -> return () }

pingLabping :: EventHandler ()
pingLabping = EventHandler
  { _description = "ping the labping"
  , _matchType = EJoin
  , _eventFunc = \ev -> case _message ev of
      Join channel -> do
        send $ Privmsg channel (Right ".labping STACKENBLOCKEN")
        disconnect
      _ -> return () }

