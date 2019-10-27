defmodule Takemefrom.GameCodeLang do
  def evaluate(game_code) do
    instructions = String.split(game_code, ".") |> Enum.reject(&(&1 == ""))

    IO.inspect instructions

    eval_instructions(instructions, [])
  end

  def eval_instructions([], accu), do: accu

  def eval_instructions(instructions, accu) do
    eval_instructions(tl(instructions), accu ++ [eval(hd(instructions))])
  end

  def eval(instruction) do
    tokens = String.split(instruction, ~r/\s/)

    IO.inspect tokens

    case hd(tokens) do
      "node" -> %{type: :node, args: tl(tokens)}
      _ -> nil
    end
  end
end
