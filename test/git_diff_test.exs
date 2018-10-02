defmodule GitDiffTest do
  use ExUnit.Case
  import File

  test "parse a valid diff" do
    text = read!("test/diff.txt")
    {flag, _} = GitDiff.parse_patch(text)
    assert flag == :ok
  end

  test "parse a valid diff that does not contain a and b" do
    text = read!("test/not_a_and_b.txt")
    {flag, _} = GitDiff.parse_patch(text)
    assert flag == :ok
  end

  test "parse a valid diff containing new files" do
    text = read!("test/new_file_diff.txt")
    {flag, _} = GitDiff.parse_patch(text)
    assert flag == :ok
  end

  test "parse an invalid diff" do
    dir = "test/bad_diffs"
    Enum.each(ls!(dir), fn(file) ->
      text = read!("#{dir}/#{file}")
      {flag, _} = GitDiff.parse_patch(text)
      assert flag == :error
    end)
  end
end
