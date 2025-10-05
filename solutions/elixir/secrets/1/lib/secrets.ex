defmodule Secrets do
  def secret_add(secret) do
    fn adder -> secret + adder end
  end

  def secret_subtract(secret) do
    fn substractor -> substractor - secret end
  end

  def secret_multiply(secret) do
    fn multiplier -> multiplier * secret end
  end

  def secret_divide(secret) do
    fn divider -> div(divider, secret) end
  end

  def secret_and(secret) do
    fn ander -> Bitwise.band(ander, secret) end
  end

  def secret_xor(secret) do
    fn xorer -> Bitwise.bxor(xorer, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    &secret_function2.(secret_function1.(&1))
  end
end
