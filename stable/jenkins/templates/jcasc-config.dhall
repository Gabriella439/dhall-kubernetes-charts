let dhall-kubernetes = ../../../dependencies/dhall-kubernetes.dhall

let utils = ../../../utils.dhall

in    λ ( `$`
        : { Values :
              { master :
                  { JCasC :
                      { enabled : Bool
                      , configScripts : List { mapKey : Text, mapValue : Text }
                      , defaultConfig : Bool
                      }
                  , sidecars : { configAutoReload : { enabled : Bool } }
                  }
              }
          , jenkins :
              { casc : { defaults : Text }
              , fullname : Text
              , name : Text
              , namespace : Text
              , labels : List { mapKey : Text, mapValue : Text }
              }
          }
        )
    →       if     `$`.Values.master.JCasC.enabled
               &&  `$`.Values.master.sidecars.configAutoReload.enabled
      
      then  let labels =
                    `$`.jenkins.labels
                  # [ { mapKey = "${`$`.jenkins.fullname}-jenkins-config"
                      , mapValue = "true"
                      }
                    ]
            
            let toConfigMap =
                    λ(key : Text)
                  → λ(val : Text)
                  → dhall-kubernetes.Resource.ConfigMap
                      dhall-kubernetes.schemas.ConfigMap::{
                      , metadata =
                          dhall-kubernetes.schemas.ObjectMeta::{
                          , name =
                              "${`$`.jenkins.fullname}-jenkins-config-${key}"
                          , namespace = Some `$`.jenkins.namespace
                          , labels = labels
                          }
                      , data = [ { mapKey = "${key}.yaml", mapValue = val } ]
                      }
            
            in    utils.range
                    Text
                    dhall-kubernetes.Resource
                    toConfigMap
                    `$`.Values.master.JCasC.configScripts
                # (       if `$`.Values.master.JCasC.defaultConfig
                    
                    then  [ dhall-kubernetes.Resource.ConfigMap
                              dhall-kubernetes.schemas.ConfigMap::{
                              , metadata =
                                  dhall-kubernetes.schemas.ObjectMeta::{
                                  , name =
                                      "${`$`.jenkins.fullname}-jenkins-jcasc-config"
                                  , namespace = Some `$`.jenkins.namespace
                                  , labels = `$`.jenkins.labels
                                  }
                              , data =
                                  toMap
                                    { `jcasc-default-config.yaml` =
                                        `$`.jenkins.casc.defaults
                                    }
                              }
                          ]
                    
                    else  [] : List dhall-kubernetes.Resource
                  )
      
      else  [] : List dhall-kubernetes.Resource
