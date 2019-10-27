let Master = ./Values/Master.dhall

let ServiceAccount = ./Values/ServiceAccount.dhall

let ServiceAccountAgent = ./Values/ServiceAccountAgent.dhall

in  { Type =
        { nameOverride : Optional Text
        , fullnameOverride : Optional Text
        , namespaceOverride : Optional Text
        , master : Master.Type
        , serviceAccount : ServiceAccount.Type
        , serviceAccountAgent : ServiceAccountAgent.Type
        }
    , default =
        { nameOverride = None Text
        , fullnameOverride = None Text
        , master = Master.default
        , serviceAccount = ServiceAccount.default
        , serviceAccountAgent = ServiceAccountAgent.default
        }
    }
