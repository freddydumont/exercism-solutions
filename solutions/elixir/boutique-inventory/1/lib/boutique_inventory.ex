defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, &%{&1 | name: String.replace(&1.name, old_word, new_word)})
  end

  def increase_quantity(item, count) do
    Map.update!(
      item,
      :quantity_by_size,
      &Map.new(&1, fn {size, quantity} -> {size, quantity + count} end)
    )
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_key, val}, acc -> val + acc end)
  end
end
