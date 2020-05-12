defmodule Jsonnet do
  @moduledoc """
  `Jsonnet` parses `.jsonnet` files and returns the content.
  """

  use Rustler, otp_app: :jsonnet, crate: :jsonnet_bindings

  @doc """
  Takes a filename and returns the data as a tagged tuple with a JSON string.
  """
  @spec parse_file(String.t()) :: {:ok | :error, String.t()}
  def parse_file(_filename), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Takes a files name returns the data as a tagged tuple with Elixir data structures. This uses
  `Jason` to deserialize the data and takes the same options.
  """
  @spec decode_file(String.t()) :: {:ok | :error, term()}
  def decode_file(filename, opts \\ []) do
    with {:ok, json} <- parse_file(filename) do
      Jason.decode(json, opts)
    end
  end
end
