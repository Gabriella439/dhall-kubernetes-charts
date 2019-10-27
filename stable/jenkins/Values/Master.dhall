let JCasC = ./Master/JCasC.dhall

let Sidecars = ./Master/Sidecars.dhall

let Ingress = ./Master/Ingress.dhall

in  { Type =
        { componentName : Text
        , adminSshKey : Text
        , jenkinsUriPrefix : Optional Text
        , servicePort : Natural
        , slaveKubernetesNamespace : Optional Text
        , kubernetes-version : Text
        , JCasC : JCasC.Type
        , sidecars : Sidecars.Type
        , ingress : Ingress.Type
        , jenkinsUrlProtocol : Optional Text
        }
    , default =
        { jenkinsUriPrefix = None Text
        , servicePort = 8080
        , slaveKubernetesNamespace = None Text
        , kubernetes-version = "1.18.1"
        , JCasC = JCasC.default
        , sidecars = Sidecars.default
        , ingress = Ingress.default
        , jenkinsUrlProtocol = None Text
        }
    }
