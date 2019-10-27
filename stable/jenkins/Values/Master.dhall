let JCasC = ./Master/JCasC.dhall

let Sidecars = ./Master/Sidecars.dhall

in  { Type = { JCasC : JCasC.Type, sidecars : Sidecars.Type }
    , default = { JCasC = JCasC.default, sidecars = Sidecars.default }
    }
