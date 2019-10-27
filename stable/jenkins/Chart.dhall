let Chart = ../../types/Chart.dhall

let Maintainer = ../../types/Maintainer.dhall

in  Chart::{
    , name = "jenkins"
    , home = Some "https://jenkins.io/"
    , appVersion = Some "lts"
    , description =
        Some
          ''
          Open source continuous integration server. It supports multiple SCM tools
          including CVS, Subversion and Git. It can execute Apache Ant and Apache Maven-based
          projects as well as arbitrary scripts.
          ''
    , sources =
        Some
          [ "https://github.com/jenkinsci/jenkins"
          , "https://github.com/jenkinsci/docker-jnlp-slave"
          , "https://github.com/maorfr/kube-tasks"
          , "https://github.com/jenkinsci/configuration-as-code-plugin"
          ]
    , icon =
        Some "https://wiki.jenkins-ci.org/download/attachments/2916393/logo.png"
    }
