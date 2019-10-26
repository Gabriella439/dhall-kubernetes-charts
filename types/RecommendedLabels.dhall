let Prelude = ../dependencies/Prelude.dhall

let `Type` =
          { `app.kubernetes.io/name` : Optional Text
          , `app.kubernetes.io/instance` : Optional Text
          , `app.kubernetes.io/version` : Optional Text
          , `app.kubernetes.io/component` : Optional Text
          , `app.kubernetes.io/part-of` : Optional Text
          , `app.kubernetes.io/managed-by` : Optional Text
          }
let RecommendedLabels =
      { Type = `Type`
      , default =
          { `app.kubernetes.io/name` = None Text
          , `app.kubernetes.io/instance` = None Text
          , `app.kubernetes.io/version` = None Text
          , `app.kubernetes.io/component` = None Text
          , `app.kubernetes.io/part-of` = None Text
          , `app.kubernetes.io/managed-by` = Some "dhall"
          }
      , flatten = λ(labels : `Type`) →
          let intermediateMap : List { mapKey : Text, mapValue : Optional Text } = toMap labels

          let flattenLabel = λ(label : { mapKey : Text, mapValue : Optional Text }) → Optional/fold Text label.mapValue (List { mapKey : Text, mapValue : Text }) (λ(value : Text) → [ { mapKey = label.mapKey, mapValue = value } ]) ([] : List { mapKey : Text, mapValue : Text })

          in  Prelude.List.concatMap { mapKey : Text, mapValue : Optional Text } { mapKey : Text, mapValue : Text } flattenLabel (toMap labels)
      }

let minimalExample =
        assert
      :   RecommendedLabels::{=}
        ≡ { `app.kubernetes.io/name` = None Text
          , `app.kubernetes.io/instance` = None Text
          , `app.kubernetes.io/version` = None Text
          , `app.kubernetes.io/component` = None Text
          , `app.kubernetes.io/part-of` = None Text
          , `app.kubernetes.io/managed-by` = Some "dhall"
          }

let fullExample =
        assert
      :   RecommendedLabels::{
          , `app.kubernetes.io/name` = Some "mysql"
          , `app.kubernetes.io/instance` = Some "wintering-rodent"
          , `app.kubernetes.io/version` = Some "5.7.21"
          , `app.kubernetes.io/component` = Some "database"
          , `app.kubernetes.io/part-of` = Some "wordpress"
          , `app.kubernetes.io/managed-by` = None Text
          }
        ≡ { `app.kubernetes.io/name` = Some "mysql"
          , `app.kubernetes.io/instance` = Some "wintering-rodent"
          , `app.kubernetes.io/version` = Some "5.7.21"
          , `app.kubernetes.io/component` = Some "database"
          , `app.kubernetes.io/part-of` = Some "wordpress"
          , `app.kubernetes.io/managed-by` = None Text
          }

in  RecommendedLabels
