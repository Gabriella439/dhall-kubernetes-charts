{ Type =
    { enabled : Bool
    , defaultConfig : Bool
    , configScripts : List { mapKey : Text, mapValue : Text }
    }
, default =
    { enabled = False
    , defaultConfig = False
    , configScripts = [] : List { mapKey : Text, mapValue : Text }
    }
}
