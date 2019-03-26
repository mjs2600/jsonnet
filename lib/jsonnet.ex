defmodule Jsonnet do
  @moduledoc """
  Documentation for Jsonnet.
  """

  use Rustler, otp_app: :jsonnet, crate: :jsonnet_bindings

  # When loading a NIF module, dummy clauses for all NIF function are required.
  # NIF dummies usually just error out when called when the NIF is not loaded, as that should never normally happen.
  def parse_file(_filename), do: :erlang.nif_error(:nif_not_loaded)

  def decode_file(filename, opts \\ []) do
    with {:ok, json} <- parse_file(filename) do
      Jason.decode(json, opts)
    end
  end
end
