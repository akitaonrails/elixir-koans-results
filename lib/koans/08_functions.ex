defmodule Functions do
  use Koans

  def greet(name) do
    "Hello, #{name}!"
  end

  koan "Functions map arguments to outputs" do
    assert greet("World") == "Hello, World!"
  end

  def multiply(a, b), do: a * b
  koan "Single line functions are cool, but mind the comma and the colon!" do
    assert 6 == multiply(2, 3)
  end

  def first(foo, bar), do: "#{foo} and #{bar}"
  def first(foo), do: "Only #{foo}"

  koan "Functions with the same name are distinguished by the number of arguments they take" do
    assert first("One", "Two") == "One and Two"
    assert first("One") == "Only One"
  end

  def repeat_again(message, times \\ 5) do
    String.duplicate(message, times)
  end

  koan "Functions can have default argument values" do
    assert repeat_again("Hello ") == "Hello Hello Hello Hello Hello "
    assert repeat_again("Hello ", 2) == "Hello Hello "
  end

  def sum_up(thing) when is_list(thing), do: :entire_list
  def sum_up(_thing), do: :single_thing

  koan "Functions can be picky and apply only to certain types" do
    assert sum_up([1 ,2 ,3]) == :entire_list
    assert sum_up(1) == :single_thing
  end

  def bigger(a,b) when a > b, do: "#{a} is bigger than #{b}"
  def bigger(a,b) when a <= b, do: "#{a} is not bigger than #{b}"

  koan "Intricate guards are possible, but be mindful of the reader" do
    assert bigger(10, 5) == "10 is bigger than 5"
    assert bigger(4, 27) == "4 is not bigger than 27"
  end

  def the_length(0), do: "It was zero"
  def the_length(number), do: "The length was #{number}"

  koan "For simpler cases, pattern matching is effective" do
    assert the_length(0) == "It was zero"
    assert the_length(5) == "The length was 5"
  end

  koan "Little anonymous functions are common, and called with a dot" do
    multiply = fn (a,b) -> a * b end
    assert multiply.(2,3) == 6
  end

  koan "You can even go shorter, by using &(..) and positional arguments" do
    multiply = &(&1 * &2)
    assert multiply.(2,3) == 6
  end

  def times_five_and_then(number, fun), do: fun.(number*5)
  def square(number), do: number * number

  koan "You can pass functions around as arguments. Place an '&' before the name and state the arity" do
    assert times_five_and_then(2, &square/1) == 100
  end

  koan "The '&' operation is not needed for anonymous functions" do
    cube = fn number -> number * number * number end
    assert times_five_and_then(2, cube) == 1000
  end

  koan "Functions can be combined elegantly with the pipe operator" do
    result = "full-name"
    |> String.split("-")
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(" ")

    assert result == "Full Name"
  end
end
