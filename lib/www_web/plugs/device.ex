defmodule WwwWeb.Plugs.Device do
  import Plug.Conn

  # @locales ["en", "fr", "de"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) do
    assign(conn, :locale, loc)
  end

  def call(conn, default) do
    coockies = Map.get(conn.req_cookies, "_www_key", nil)
    IO.puts """
    ACHTUNG: #{inspect(coockies)}
    """
    assign(conn, :locale, default)
  end
end
