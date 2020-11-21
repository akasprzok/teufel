use Mix.Config

alias Teufel.Weapon.{Prefix, Suffix}

default_weapon = %{
  type: :sword,
  name: "Sword",
  level: 0,
  attack_min: 2,
  attack_max: 5,
  scaling_factor: 1.2
}

default_prefix = %{
  name: "Fiery",
  stat_min: 1,
  stat_max: 2,
  stat: :fire_damage
}

default_suffix = %{
  name: "Dexterity",
  stat_min: 1,
  stat_max: 2,
  stat: :dexterity
}

default_rarity = %{
  name: "",
  weight: 10
}

config :teufel, :weapons,
  weapons: [
    default_weapon,
    %{default_weapon | type: :axe, name: "Axe", attack_min: 3, attack_max: 6},
    %{default_weapon | type: :polearm, name: "Polearm", attack_min: 1, attack_max: 5},
    %{default_weapon | type: :bow, name: "Bow", attack_min: 2, attack_max: 4}
  ],
  prefixes: [
    default_prefix,
    %{default_prefix | name: "Chilling", stat: :ice_damage}
  ],
  suffixes: [
    default_suffix,
    %{default_suffix | name: "Strength", stat: :strength}
  ],
  rarities: [
    %{default_rarity | name: "Broken", weight: 1},
    %{default_rarity | name: "Shabby", weight: 2},
    %{default_rarity | name: "Unassuming", weight: 5},
    default_rarity,
    %{default_rarity | name: "Generic", weight: 5},
    %{default_rarity | name: "Rad", weight: 2},
    %{default_rarity | name: "Epic", weight: 1}
  ]
