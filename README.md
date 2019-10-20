# `dhall-kubernetes-charts`

This is a repository that provides the Dhall analog of the
[Helm `charts` repository](https://github.com/helm/charts).  In other words,
this repository contains reusable Dhall expressions for popular Kubernetes
configurations.

Carefully note that this repository is not supposed to generate Helm charts,
but rather to replace them.  In other words, this repository generates
Kubernetes resources directly without going through a Helm intermediate.

## How to translate Helm charts to Dhall charts

Each Dhall "chart" is a record with the following Dhall type:

```dhall
{ -- The Kubernetes resource specification, designed to generate an all-in-one
  -- YAML file containing all of the resources
  --
  -- This is analogous to the `./template` subdirectory and the `./NOTES.txt`
  -- file of a Helm chart
  template :
    DefaultValues ⩓ RequiredValues → { resources : List Resource, notes : Text }

  -- Default inputs for the chart, designed for use with Dhall's `::` record
  -- completion operator
  --
  -- This is analogous to the `values.yaml` file of a Helm chart
, Values : { Type : Type, default : DefaultValues }

  -- Metadata about the chart, useful for programmatic queries
  --
  -- This is analogous to the `./Chart.yaml` file of a Helm chart
, metadata : Metadata
}
```

... so that you can use the chart like this:

```dhall
let jenkins = ./jenkins/chart.dhall

in  jenkins.template jenkins.Values::{
    , image = "jenkins/lts"
    , imagePullPolicy = "IfNotPresent"
    }
```

See the documentation for [`./type/Chart.dhall`](./type/Chart.dhall), which
provides a little more detail.

## Development status

This repository is entirely experimental.  Feel free to contribute if you want
but I might mass-refactor things while figuring out best practices for encoding
charts in Dhall.
