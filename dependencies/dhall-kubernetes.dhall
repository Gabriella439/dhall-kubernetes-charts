{- `dhall-kubernetes` does not yet have a `./package.dhall` file, so create one
   ourselves for now
-}
{ schemas =
    https://raw.githubusercontent.com/dhall-lang/dhall-kubernetes/4ef46543ceff0e10978cca542952c56ee6e47b93/schemas.dhall sha256:0a362a64a631fe7911f71438fa05acdcdf6469850cce4f910e4cf126315d1011
, Resource =
    https://raw.githubusercontent.com/dhall-lang/dhall-kubernetes/4ef46543ceff0e10978cca542952c56ee6e47b93/typesUnion.dhall sha256:8e8db456b218b93f8241d497e54d07214b132523fe84263e6c03496c141a8b18
}
