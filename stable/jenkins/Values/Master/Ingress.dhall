let TLS = ./Ingress/TLS.dhall

in  { Type =
        { enabled : Bool
        , apiVersion : Text
        , labels : List { mapKey : Text, mapValue : Text }
        , annotations : List { mapKey : Text, mapValue : Text }
        , path : Optional Text
        , hostName : Optional Text
        , tls : List TLS.Type
        }
    , default =
        { enabled = False
        , apiVersion = "extensions/v1beta1"
        , labels = [] : List { mapKey : Text, mapValue : Text }
        , annotations = [] : List { mapKey : Text, mapValue : Text }
        , path = None Text
        , hostName = None Text
        , tls = [] : List TLS.Type
        }
    }
