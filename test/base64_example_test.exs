defmodule Base64ExampleTest do
  use ExUnit.Case
  doctest Base64Example

  test "greets the world" do
    assert Base64Example.hello() == :world
  end
end
