-- This schema is used as part of the `./Chart.dhall` schema
let Maintainer =
      { Type = { name : Text, email : Optional Text, url : Optional Text }
      , default = { email = None Text, url = None Text }
      }

let minimalExample =
        assert
      :   Maintainer::{ name = "John Doe" }
        ≡ { name = "John Doe", email = None Text, url = None Text }

let completeExample =
        assert
      :   Maintainer::{
          , name = "Jane Smith"
          , email = Some "jane@example.com"
          , url = Some "https://example.com/jane"
          }
        ≡ { name = "Jane Smith"
          , email = Some "jane@example.com"
          , url = Some "https://example.com/jane"
          }

in  Maintainer
