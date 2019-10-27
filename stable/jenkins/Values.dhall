let Master = ./Values/Master.dhall

in  { Type = { master : Master.Type }, default = { master = Master.default } }
