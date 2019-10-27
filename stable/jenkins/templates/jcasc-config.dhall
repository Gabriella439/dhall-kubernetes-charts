let k8s = ../../../dependencies/dhall-kubernetes.dhall

let utils = ../../../utils.dhall

let Values = ../Values.dhall

in    λ (Values : Values.Type)
    → λ (jenkins :
              { casc : { defaults : Text }
              , fullname : Text
              , name : Text
              , namespace : Text
              , labels : List { mapKey : Text, mapValue : Text }
              }
        )
    → let labels =
              jenkins.labels
            # [ { mapKey = "${jenkins.fullname}-jenkins-config"
                , mapValue = "true"
                }
              ]
      
      let defaultConfig =
            k8s.Resource.ConfigMap
              k8s.schemas.ConfigMap::{
              , metadata =
                  k8s.schemas.ObjectMeta::{
                  , name = "${jenkins.fullname}-jenkins-jcasc-config"
                  , namespace = Some jenkins.namespace
                  , labels = jenkins.labels
                  }
              , data =
                  toMap
                    { `jcasc-default-config.yaml` = jenkins.casc.defaults }
              }
      
      let toConfigMap =
              λ(key : Text)
            → λ(val : Text)
            → k8s.Resource.ConfigMap
                k8s.schemas.ConfigMap::{
                , metadata =
                    k8s.schemas.ObjectMeta::{
                    , name = "${jenkins.fullname}-jenkins-config-${key}"
                    , namespace = Some jenkins.namespace
                    , labels = labels
                    }
                , data = [ { mapKey = "${key}.yaml", mapValue = val } ]
                }
      
      in  utils.optional
            (     Values.master.JCasC.enabled
              &&  Values.master.sidecars.configAutoReload.enabled
            )
            (   utils.range
                  Text
                  k8s.Resource
                  toConfigMap
                  Values.master.JCasC.configScripts
              # utils.optional
                  Values.master.JCasC.defaultConfig
                  [ defaultConfig ]
            )
