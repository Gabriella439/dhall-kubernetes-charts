let Prelude = ./dependencies/Prelude.dhall

let dhall-kubernetes = ./dependencies/dhall-kubernetes.dhall

let Resource = dhall-kubernetes.Resource

let default =
        λ(defaultValue : Text)
      → λ(overrideValue : Optional Text)
      → Optional/fold Text overrideValue Text (λ(x : Text) → x) defaultValue

let range
    :   ∀(a : Type)
      → ∀(b : Type)
      → (∀(key : Text) → ∀(val : a) → b)
      → List { mapKey : Text, mapValue : a }
      → List b
    =   λ(a : Type)
      → λ(b : Type)
      → λ(f : ∀(key : Text) → ∀(val : a) → b)
      → Prelude.List.map
          { mapKey : Text, mapValue : a }
          b
          (λ(x : { mapKey : Text, mapValue : a }) → f x.mapKey x.mapValue)

let optional =
        λ(condition : Bool)
      → λ(conditionalResources : List Resource)
      → if condition then conditionalResources else [] : List Resource

in  { default = default, range = range, optional = optional }
