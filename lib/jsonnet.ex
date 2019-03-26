defmodule Jsonnet do
  @moduledoc """
  Documentation for Jsonnet.
  """

  use Rustler, otp_app: :jsonnet, crate: :jsonnet_bindings

  @spec parse_file(String.t()) :: {:ok | :error, String.t()}
  def parse_file(_filename), do: :erlang.nif_error(:nif_not_loaded)

  @spec decode_file(String.t()) :: {:ok | :error, term()}
  def decode_file(filename, opts \\ []) do
    with {:ok, json} <- parse_file(filename) do
      Jason.decode(json, opts)
    end
  end
end
