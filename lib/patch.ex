defmodule GitDiff.Patch do
  @moduledoc """
  Every 'git diff' command generates one or more patches.
  """
  
  @doc """
  Defines the Patch struct.
  
  * :from - The file name preimage.
  * :branch1 - The original branch
  * :branch2 - The other branch
  * :to - The file name postimages.
  * :headers - A list of headers for the patch.
  * :chunks - A list of chunks of changes contained in this patch. See `GitDiff.Chunk`.
  """
  defstruct from: nil, to: nil, headers: %{}, chunks: [], branch1: "", branch2: ""
end
