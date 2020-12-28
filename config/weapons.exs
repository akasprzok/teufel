use Mix.Config

alias Teufel.Weapon.{Prefix, Suffix}

config :teufel, :weapons,
  weapons: [
    %{
      name: "Sword",
      attack: {:slashing, 2..5},
      scaling_factor: 1.2
    },
    %{
      name: "Axe",
      attack: {:slashing, 3 - 6},
      scaling_factor: 1.2
    },
    %{
      name: "Polearm",
      attack: {:piercing, 1..5},
      scaling_factor: 1.2
    },
    %{
      name: "Bow",
      attack: {:piercing, 2..4},
      scaling_factor: 1.2
    }
  ],
  prefixes: [
    %{name: "Fiery", stat: {:fire_damage, 2..4}},
    %{name: "Chilling", stat: {:ice_damage, 2..4}}
  ],
  suffixes: [
    %{name: "Dexterity", stat: {:dexterity, 1..2}},
    %{name: "Strength", stat: {:strength, 1..2}}
  ],
  rarities: [
    %{name: "Broken", weight: 1},
    %{name: "Shabby", weight: 2},
    %{name: "Unassuming", weight: 5},
    %{name: "Ordinary", weight: 10},
    %{name: "Generic", weight: 5},
    %{name: "Rad", weight: 2},
    %{name: "Epic", weight: 1}
  ]
