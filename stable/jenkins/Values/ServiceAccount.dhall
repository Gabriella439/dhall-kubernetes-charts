{ Type =
    { create : Bool
    , name : Optional Text
    , annotations : List { mapKey : Text, mapValue : Text }
    }
, default =
    { create = True
    , name = None Text
    , annotations = [] : List { mapKey : Text, mapValue : Text }
    }
}
