defmodule JsonnetTest do
  use ExUnit.Case
  doctest Jsonnet

  test "decoding jsonnet files" do
    assert {:ok,
            %{
              person1: %{name: "Alice", welcome: "Hello Alice!"},
              person2: %{name: "Bob", welcome: "Hello Bob!"}
            }} ==
             Jsonnet.decode_file("./test/test.jsonnet", keys: :atoms)
  end

  test "decoding missing jsonnet files" do
    assert {:error, "Could not read file"} ==
             Jsonnet.decode_file("does_not_exist.jsonnet", keys: :atoms)
  end

  test "decoding bad jsonnet files" do
    assert {:error, "Could not read file"} ==
             Jsonnet.decode_file("./test/bad.jsonnet", keys: :atoms)
  end
end
