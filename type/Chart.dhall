{-  This is the type representing how we translate Helm charts to Dhall

    • The `input` type parameter is the type of the input to the template.  This
      field will be a record type of the form:

          input = DefaultValues ⩓ RequiredValues

    • The `values` type parameter is analogous to the schema of the
      `./Values.yaml` file for a Helm chart

      This type parameter is the type of the default values supplied to the
      chart.  This field will be a record type that is a subset of the `input`
      field's type:

          values = DefaultValues

    • The `template` field is analogous to the `./templates/` subdirectory of a
      Helm chart

      This field is a function whose input is a record of configuration options
      (i.e. `input`) and whose output contains:

      • A `resources` field containing a `List` of Kubernetes resources to apply

        You can supply this field to `dhall-to-yaml` to generate a valid YAML
        file that you can apply, like so:

            dhall-to-yaml --documents --file ./resources.dhall | kubectl apply --filename=-

      • A `notes` field containing useful information, analogous to the
        `./NOTES.txt` file provided by each Helm chart

    • The `Values` field is analogous to the `./Values.yaml` file for a Helm
      chart

      This field stores both the record of `default` values and their `Type`,
      suitable for use with Dhall's `::` record completion operator

    • The `metadata` field is analogous to the `./Chart.yaml` file for a Helm
      chart
-}
let dhall-kubernetes = ../dependency/dhall-kubernetes.dhall

let Metadata = ./Metadata.dhall

let Chart
    : ∀(input : Type) → ∀(values : Type) → Kind
    =   λ(input : Type)
      → λ(values : Type)
      → { template :
            input → { resources : List dhall-kubernetes.Resource, notes : Text }
        , Values : { Type : Type, default : values }
        , metadata : Metadata.Type
        }

in  Chart
