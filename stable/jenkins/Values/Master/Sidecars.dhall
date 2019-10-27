let ConfigAutoReload = ./SideCars/ConfigAutoReload.dhall

in  { Type = { configAutoReload : ConfigAutoReload.Type }
    , default = { configAutoReload = ConfigAutoReload.default }
    }
