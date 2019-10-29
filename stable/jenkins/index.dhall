let Prelude = ../../dependencies/Prelude.dhall

let dhall-kubernetes = ../../dependencies/dhall-kubernetes.dhall

let RecommendedLabels = ../../types/RecommendedLabels.dhall

let utils = ../../utils.dhall

let TLS = ./Values/Master/Ingress/TLS.dhall

let Chart = ./Chart.dhall

let Values = ./Values.dhall

let jcasc-config = ./templates/jcasc-config.dhall

let template =
        λ(Release : { Name : Text, Namespace : Text })
      → λ(Values : Values.Type)
      → let jenkins =
              let name = utils.default Chart.name Values.nameOverride
              
              let fullname =
                    utils.default
                      "${Release.Name}-${name}"
                      Values.fullnameOverride
              
              in  { name = name
                  , namespace =
                      utils.default Release.Namespace Values.namespaceOverride
                  , master =
                      { slaveKubernetesNamespace =
                          utils.default
                            ( utils.default
                                Release.Namespace
                                Values.namespaceOverride
                            )
                            Values.master.slaveKubernetesNamespace
                      }
                  , fullname = fullname
                  , url =
                      let defaultScheme =
                                  if Prelude.List.null
                                       TLS.Type
                                       Values.master.ingress.tls
                            
                            then  "https"
                            
                            else  "http"
                      
                      let scheme =
                            utils.default
                              defaultScheme
                              Values.master.jenkinsUrlProtocol
                      
                      let defaultHost =
                            "${fullname}:${Natural/show
                                             Values.master.servicePort}"
                      
                      let host =
                            utils.default
                              defaultHost
                              Values.master.ingress.hostName
                      
                      let prefix =
                            utils.default "" Values.master.jenkinsUriPrefix
                      
                      in  "${scheme}://${host}${prefix}"
                  , casc = { defaults = "" }
                  , kubernetes-version = Values.master.kubernetes-version
                  , gen-key = Values.master.adminSshKey
                  , serviceAccountName =
                      let defaultAccountName =
                                  if Values.serviceAccount.create
                            
                            then  fullname
                            
                            else  "default"
                      
                      in  utils.default
                            defaultAccountName
                            Values.serviceAccount.name
                  , serviceAccountAgentName =
                      let defaultAgentName =
                                  if Values.serviceAccountAgent.create
                            
                            then  "${fullname}-agent"
                            
                            else  "default"
                      
                      in  utils.default
                            defaultAgentName
                            Values.serviceAccountAgent.name
                  , labels =
                      RecommendedLabels.flatten
                        RecommendedLabels::{
                        , `app.kubernetes.io/name` = Some name
                        , `app.kubernetes.io/instance` = Some Release.Name
                        , `app.kubernetes.io/component` =
                            Some Values.master.componentName
                        }
                  }
        
        in  { resources = jcasc-config Values jenkins, notes = "" }

in  { Values = Values, Chart = Chart, template = template }
