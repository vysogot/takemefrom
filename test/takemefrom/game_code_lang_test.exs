defmodule Takemefrom.GameCodeLangTest do
  use Takemefrom.DataCase

  alias Takemefrom.GameCodeLang

  test "given an empty program it just returns empty data structures" do
    assert GameCodeLang.evaluate("") == %{
      nodes: [],
      edges: []
    }
  end

  test "allows to define a node" do
    assert GameCodeLang.evaluate("node content \"Are you ready to begin?\".") == %{
      nodes: [%{id: "node#1", content: "Are you ready to begin?"}],
      edges: []
    }
  end
end
