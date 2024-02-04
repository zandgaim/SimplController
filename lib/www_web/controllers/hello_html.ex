defmodule WwwWeb.HelloHTML do
  use WwwWeb, :html

  embed_templates "hello_html/*"
end
