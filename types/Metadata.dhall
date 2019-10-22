{-  This file represents the schema for chart-related metadata, similar to the
    information that Helm stores in a `./Chart.yaml` file within each chart

    The following fields present in Helm chart metadata are not present in the
    corresponding Dhall chart metadata:

    • apiVersion - This repository's chart-related types are not versioned.
      If you still need a version for your own internal purposes then use the
      output of the following command:

      ```
      $ dhall hash --file ./types.dhall
      ```

      ... which can be automated within Dhall once the following proposal is
      standardized:

      https://github.com/dhall-lang/dhall-lang/issues/739

    • version - Charts in this repository are not versioned using semantic
      version strings.  Instead, use the `git` revision for this repository to
      uniquely a specific version of a chart

    • engine - The engine for this repository will always be Dhall, so there is
      no reason to make the engine configurable

    • tillerVersion - This repository generates Kubernetes resources directly
      (i.e. no Helm/Tiller intermediate) so there is no need to specify a Tiller
      version
-}
let Maintainer = ./Maintainer.dhall

let Metadata =
      { Type =
          { name : Text
          , kubeVersion : Optional Text
          , description : Optional Text
          , keywords : Optional (List Text)
          , home : Optional Text
          , sources : Optional (List Text)
          , maintainers : Optional (List Maintainer.Type)
          , icon : Optional Text
          , appVersion : Optional Text
          , deprecated : Optional Bool
          }
      , default =
          { kubeVersion = None Text
          , description = None Text
          , keywords = None (List Text)
          , home = None Text
          , sources = None (List Text)
          , maintainers = None (List Maintainer.Type)
          , icon = None Text
          , appVersion = None Text
          , deprecated = None Bool
          }
      }

let minimalExample =
        assert
      :   Metadata::{
          , name = "Jenkins"
          }
        ≡ { appVersion = None Text
          , deprecated = None Bool
          , description = None Text
          , home = None Text
          , icon = None Text
          , keywords = None (List Text)
          , kubeVersion = None Text
          , maintainers =
              None
                ( List
                    { email : Optional Text, name : Text, url : Optional Text }
                )
          , name = "Jenkins"
          , sources = None (List Text)
          }

let completeExample =
        assert
      :   Metadata::{
          , name = "Jenkins"
          , kubeVersion = Some "^1.14-0"
          , description =
              Some
                ''
                Open source continuous integration server. It supports multiple SCM tools
                including CVS, Subversion and Git. It can execute Apache Ant and Apache
                Maven-based projects as well as arbitrary scripts.
                ''
          , keywords = Some [ "ci", "cd" ]
          , home = Some "https://jenkins.io"
          , sources =
              Some
                [ "https://github.com/jenkinsci/jenkins"
                , "https://github.com/jenkinsci/docker-jnlp-slave"
                , "https://github.com/maorfr/kube-tasks"
                , "https://github.com/jenkinsci/configuration-as-code-plugin"
                ]
          , appVersion = Some "lts"
          , maintainers =
              Some
                [ Maintainer::{
                  , name = "example"
                  , email = Some "maintainer@example.com"
                  }
                ]
          , icon =
              Some
                "https://wiki.jenkins-ci.org/download/attachments/2916393/logo.png"
          , deprecated = Some False
          }
        ≡ { appVersion = Some "lts"
          , deprecated = Some False
          , description =
              Some
                ''
                Open source continuous integration server. It supports multiple SCM tools
                including CVS, Subversion and Git. It can execute Apache Ant and Apache
                Maven-based projects as well as arbitrary scripts.
                ''
          , home = Some "https://jenkins.io"
          , icon =
              Some
                "https://wiki.jenkins-ci.org/download/attachments/2916393/logo.png"
          , keywords = Some [ "ci", "cd" ]
          , kubeVersion = Some "^1.14-0"
          , maintainers =
              Some
                [ Maintainer::{
                  , name = "example"
                  , email = Some "maintainer@example.com"
                  }
                ]
          , name = "Jenkins"
          , sources =
              Some
                [ "https://github.com/jenkinsci/jenkins"
                , "https://github.com/jenkinsci/docker-jnlp-slave"
                , "https://github.com/maorfr/kube-tasks"
                , "https://github.com/jenkinsci/configuration-as-code-plugin"
                ]
          }

in  Metadata
