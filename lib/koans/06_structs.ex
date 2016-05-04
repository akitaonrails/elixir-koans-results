defmodule Structs do
  use Koans

  defmodule Person do
    defstruct [:name, :age]
  end

  koan "Structs are defined and named after a module" do
    person = %Person{}
    assert person == %Person{}
  end

  koan "Unless previously defined, fields begin as nil" do
    nobody = %Person{}
    assert nobody.age == nil
  end

  koan "You can pass initial values to structs" do
    joe = %Person{name: "Joe", age: 23}
    assert joe.name == "Joe"
  end

  koan "Update fields with the cons '|' operator" do
    joe = %Person{name: "Joe", age: 23}
    older = %{joe | age: joe.age + 10}
    assert older.age == 33
  end

  defmodule Plane do
    defstruct passengers: 0, maker: :boeing
  end

  def plane?(%Plane{}), do: true
  def plane?(_), do: false

  koan "Or onto the type of the struct itself" do
    assert plane?(%Plane{passengers: 417, maker: :boeing}) == true
    assert plane?(%Person{}) == false
  end

  koan "Struct can be treated like maps" do
    silvia = %Person{age: 22, name: "Silvia"}

    assert Map.fetch(silvia, :age) == {:ok, 22}
  end
end
