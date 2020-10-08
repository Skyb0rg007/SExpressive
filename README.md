# SExpressive

This library is a port of `s-cargot`, with the following changes:

* There is only one representation of s-expressions
  - The library provides pattern synonyms for working with lists and dotted lists
* The parser uses `megaparsec` instead of `parsec`
  - Additionally, the parser is generic over `MonadParsec`
    instances satisfying the `Token s ~ Char` constraint
* The library is much slimmer
  - I'm using this for a school project, so it's important that I understand all the code

However, do note that the `src/SExpressive/Print.hs` file is basically copied word-for-word,
so all credit to the writers of `s-cargot`.

