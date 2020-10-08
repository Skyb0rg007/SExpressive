module Main where

import           Data.Functor.Identity
import           Data.Text                  (Text)
import qualified Data.Text                  as Text
import qualified Data.Text.IO               as Text.IO
import           Data.Void
import           SExpressive.Parse
import           SExpressive.Print
import           SExpressive.Types
import           System.Environment
import           Text.Megaparsec
import qualified Text.Megaparsec.Char.Lexer as L

printer :: Printer Int
printer = Printer
    { atomPrinter  = Text.pack . show
    , swingIndent  = const Align
    , indentAmount = 2
    , maxWidth     = Just 20
    , indentPrint  = True
    }

sexp :: SExpr Int
sexp =
    SList
    [ SAtom 1
    , SAtom 2
    , SCons (SAtom 1) (SAtom 2)
    , SList $ map SAtom [1 .. 20]
    ]

sexprParser :: SExprParser (Parsec Void String) Int
sexprParser = SExprParser
    { parseAtom = L.decimal
    , readerMap = mempty
    , comment   = Nothing
    }

main :: IO ()
main = do
    input:_ <- getArgs
    case runIdentity $ decodeOne sexprParser input of
      Left err -> putStrLn err
      Right ast -> Text.IO.putStrLn $ encodeOne printer ast
    -- Text.IO.putStrLn $ encodeOne printer sexp
