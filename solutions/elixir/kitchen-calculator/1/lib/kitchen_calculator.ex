defmodule KitchenCalculator do
  @type unit :: :cup | :fluid_ounce | :teaspoon | :tablespoon | :milliliter
  @type volume_pair :: {unit(), float()}

  @spec get_volume(volume_pair()) :: float()
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  @spec to_milliliter(volume_pair()) :: {:milliliter, float()}
  def to_milliliter({:cup, volume} = _), do: {:milliliter, volume * 240}
  def to_milliliter({:fluid_ounce, volume} = _), do: {:milliliter, volume * 30}
  def to_milliliter({:teaspoon, volume} = _), do: {:milliliter, volume * 5}
  def to_milliliter({:tablespoon, volume} = _), do: {:milliliter, volume * 15}
  def to_milliliter({:milliliter, volume} = _), do: {:milliliter, volume}

  @spec from_milliliter({:milliliter, float()}, unit()) :: {unit(), float()}
  def from_milliliter({_, volume} = _, :cup = _unit), do: {:cup, volume / 240}
  def from_milliliter({_, volume} = _, :fluid_ounce = _unit), do: {:fluid_ounce, volume / 30}
  def from_milliliter({_, volume} = _, :teaspoon = _unit), do: {:teaspoon, volume / 5}
  def from_milliliter({_, volume} = _, :tablespoon = _unit), do: {:tablespoon, volume / 15}
  def from_milliliter({_, volume} = _, :milliliter = _unit), do: {:milliliter, volume}

  @spec convert(volume_pair(), unit()) :: volume_pair()
  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
