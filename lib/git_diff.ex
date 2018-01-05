  Returns `{:ok, [%GitDiff.Patch{}]}` in case of success, `{:error, :unrecognized_format}` otherwise.
      if Enum.all?(parsed_diff, fn(%Patch{} = _patch) -> true; (_) -> false end) do
          process_chunk(%{from_line_number: nil, to_line_number: nil}, %Chunk{}, lines)
  defp process_chunk(_, chunk, []) do
    %{chunk | lines: Enum.reverse(chunk.lines)}
  end
  defp process_chunk(context, chunk, ["" |lines]), do: process_chunk(context, chunk, lines)
  defp process_chunk(context, chunk, [line |lines]) do
    {context, chunk} =
        "@@" <> text ->
          results = Regex.named_captures(~r/ -(?<from_start_line>[0-9]+),(?<from_num_lines>[0-9]+) \+(?<to_start_line>[0-9]+),(?<to_num_lines>[0-9]+) @@( (?<context>.+))?/, text)
          {
            %{context | from_line_number: String.to_integer(results["from_start_line"]), to_line_number: String.to_integer(results["to_start_line"])},
            %{chunk | from_num_lines: results["from_num_lines"],
                      from_start_line: results["from_start_line"],
                      to_num_lines: results["to_num_lines"],
                      to_start_line: results["to_start_line"],
                      context: results["context"],
                      header: "@@" <> text
          }}
        " " <> text ->
          line =
            %Line{
              text: text,
              type: :context,
              to_line_number: context.to_line_number,
              from_line_number: context.from_line_number
            }
            
          {
            %{context | to_line_number: context.to_line_number + 1, from_line_number: context.from_line_number + 1},
            %{chunk | lines: [line | chunk.lines]}
          }
        "+" <> text ->
          line =
            %Line{
              text: text,
              type: :add,
              to_line_number: context.to_line_number
            }
            
          {
            %{context | to_line_number: context.to_line_number + 1},
            %{chunk | lines: [line | chunk.lines]}
          }
        "-" <> text ->
          line =
            %Line{
              text: text,
              type: :remove,
              from_line_number: context.from_line_number
            }
            
          {
            %{context | from_line_number: context.from_line_number + 1},
            %{chunk | lines: [line | chunk.lines]}
    process_chunk(context, chunk, lines)