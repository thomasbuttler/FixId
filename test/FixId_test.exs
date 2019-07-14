defmodule FixIdTest do
  use ExUnit.Case

  test "run main" do
    assert FixId.main(["test/ids_file", "test/dir"]) == ok
  end

end
