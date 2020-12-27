defmodule Teufel.Game.WeaponGen do
  @moduledoc """
  GenServer for generating weapons from a supplied config.
  """

  require Logger

  use GenServer

  alias Teufel.Weapon
  alias Teufel.Weapon.{Prefix, Suffix}

  # Client

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(config \\ []) do
    Logger.info("Starting #{__MODULE__}")
    GenServer.start_link(__MODULE__, config, name: __MODULE__)
  end

  @doc """
  Generate a weapon.

  Generates a weapon based on the provided options.

  Options:
    * level: the level that the item should be generated at. Default: 0.
    * type: the type that the generated item should have. If not specified, the weapon type will be randomized among all possible options.
  """
  @spec generate(keyword()) :: Weapon.t()
  def generate(opts \\ []) do
    GenServer.call(__MODULE__, {:generate, opts})
  end

  def list_config() do
    GenServer.call(__MODULE__, {:list_config})
  end

  # Server

  @impl true
  def init(_config) do
    {:ok, configure()}
  end

  defp configure() do
    config = Application.get_env(:teufel, :weapons)

    weapons =
      Keyword.get(config, :weapons)
      |> Enum.map(&Weapon.from_map/1)

    prefixes =
      Keyword.get(config, :prefixes)
      |> Enum.map(&Prefix.from_map/1)

    suffixes =
      Keyword.get(config, :suffixes)
      |> Enum.map(&Suffix.from_map/1)

    %{
      weapons: weapons,
      suffixes: suffixes,
      prefixes: prefixes
    }
  end

  @impl true
  def handle_call(
        {:generate, opts},
        _from,
        %{weapons: weapons, suffixes: suffixes, prefixes: prefixes} = config
      ) do
    weapon_type = Keyword.get(opts, :type, nil)
    level = Keyword.get(opts, :level, 0)
    suffix = roll_suffix(suffixes)
    prefix = roll_prefix(prefixes)

    weapon =
      weapons
      |> fetch_weapon(weapon_type)
      |> Map.put(:level, level)
      |> Map.put(:suffix, suffix)
      |> Map.put(:prefix, prefix)

    {:reply, weapon, config}
  end

  @impl true
  def handle_call({:list_config}, _from, config) do
    {:reply, config, config}
  end

  @spec fetch_weapon(Weapon.t(), atom()) :: Weapon.t()
  defp fetch_weapon(weapons, nil) do
    Enum.random(weapons)
  end

  defp fetch_weapon(weapons, weapon_type) do
    weapons
    |> Enum.filter(fn %{type: type} -> type == weapon_type end)
    |> List.first()
  end

  defp roll_suffix(suffixes) do
    case Enum.random(0..1) do
      0 -> nil
      1 -> random_suffix(suffixes)
    end
  end

  defp roll_prefix(prefixes) do
    case Enum.random(0..1) do
      0 -> nil
      1 -> random_prefix(prefixes)
    end
  end

  defp random_suffix(suffixes) do
    Enum.random(suffixes)
  end

  defp random_prefix(prefixes) do
    Enum.random(prefixes)
  end
end
