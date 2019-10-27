let RecommendedLabels = ../../../types/RecommendedLabels.dhall

let utils = ../../../utils.dhall

in  { toLabels =
          λ ( `$`
            : { Chart : { Name : Text }
              , Release : { Name : Text }
              , Values :
                  { master : { componentName : Text }
                  , nameOverride : Optional Text
                  }
              }
            )
        → RecommendedLabels.flatten
            RecommendedLabels::{
            , `app.kubernetes.io/name` =
                Some (utils.default `$`.Chart.Name `$`.Values.nameOverride)
            , `app.kubernetes.io/instance` = Some `$`.Release.Name
            , `app.kubernetes.io/component` =
                Some `$`.Values.master.componentName
            }
    }
