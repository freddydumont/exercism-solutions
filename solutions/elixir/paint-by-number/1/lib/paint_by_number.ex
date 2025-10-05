defmodule PaintByNumber do
  def palette_bit_size(color_count), do: palette_bit_size(color_count, 1)

  def palette_bit_size(color_count, n) do
    if Integer.pow(2, n) >= color_count, do: n, else: palette_bit_size(color_count, n + 1)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    n = palette_bit_size(color_count)
    <<pixel_color_index::size(n), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    n = palette_bit_size(color_count)

    case picture do
      <<value::size(n), _::bitstring>> -> value
      _ -> nil
    end
  end

  def drop_first_pixel(picture, color_count) do
    n = palette_bit_size(color_count)

    case picture do
      <<_::size(n), rest::bitstring>> -> rest
      _ -> <<>>
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
