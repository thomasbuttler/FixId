defmodule FixId do
  use Application
  require Logger

  @moduledoc """
  Process a directory tree, changing uids and gids as specified in a mapping file
  """

  @doc """
  get_fixes! reads the mapping file, and returns a list of two maps, the uid map and the gid map.
  It can raise an error if there is trouble reading the file name (e.g., it doesn't exist).

  ## Parameters

      - ids_file: string specifying the file from which to read uid and gid maps

  ## Examples

      FixId.get_fixes("tests/ids_file")
      
      where "tests/ids_file" contains something like

      uids
      # uid_before uid_after
      1 2
      400 500
      gids
      # gid_before gid_after
      1 2
      600 700
      
      A line beginning with the space delimited string "uids" starts collecting
      mappings from one uid integer to another (the rest of the line is ignored).
      
      A line beginning with the space delimited string "gids" starts collecting
      mappings from one gid integer to another (the rest of the line is ignored).
      
      A line with two space separated integers gets interpreted as either a uid or
      gid mapping.
      
      A line with (optional) spaces, "#", a space, and (optional) other
      content gets ignored (intended to allow comments)
      
      A line that match none of the preceding patterns gets ignored, but it is
      safer to mark comments with a "# " as the first characters of the line.
  """
  @spec get_fixes!(String.t()) :: {%{}, %{}}
  def get_fixes!(ids_file) do
    [uids, gids, _] =
      File.stream!(ids_file)
      |> Stream.map(&String.split(&1))
      # comment facility - ignore all but first two elements
      |> Stream.map(fn
        [a, b | _] -> [a, b]
        a -> a
      end)
      # primitive comment facility
      |> Stream.filter(fn
        ["#" | _] -> false
        _ -> true
      end)
      |> Enum.reduce(
        [%{}, %{}, :collect_uid_mapping],
        fn
          [uid_before, uid_after], [uids, gids, :collect_uid_mapping] ->
            [
              Map.put(uids, String.to_integer(uid_before), String.to_integer(uid_after)),
              gids,
              :collect_uid_mapping
            ]

          [gid_before, gid_after], [uids, gids, :collect_gid_mapping] ->
            [
              uids,
              Map.put(gids, String.to_integer(gid_before), String.to_integer(gid_after)),
              :collect_gid_mapping
            ]

          ["gids" | _], [uids, gids, _] ->
            [uids, gids, :collect_gid_mapping]

          ["uids" | _], [uids, gids, _] ->
            [uids, gids, :collect_uid_mapping]

          _, state ->
            state
        end
      )

    # sanity checks that no value of uids should appear as a key of uids,
    # and no value of gids appears as a key of gids
    Enum.each(uids, fn {_key, value} ->
      uids[value] && raise "Error: circular mapping in uids #{value}"
    end)

    Enum.each(gids, fn {_key, value} ->
      gids[value] && raise "Error: circular mapping in gids #{value}"
    end)

    {uids, gids}
  end

  @doc """
  major device numbers are unique to the file system, and minor numbers are always zero,
  *except* when the file is a device (block or character).  Practically, it means we can
  use a difference in the major device number of directories to identify a mount point.
  """

  @spec procdir({%{}, %{}}, String.t()) :: :ok
  def procdir({fix_uids, fix_gids}, path_name) do
    {:ok, %File.Stat{major_device: major}} = File.lstat(path_name)
    # accept all
    filter_entry = fn _name -> true end

    proc_entry = fn name, %File.Stat{uid: uid, gid: gid, type: type} ->
      if type != :symlink do
        if Map.has_key?(fix_uids, uid) do
          if Map.has_key?(fix_gids, gid) do
            IO.puts(
              "#{name} needs its uid changed from #{uid} to #{fix_uids[uid]} and its gid changed from #{
                gid
              } to #{fix_gids[gid]}\n"
            )

            File.chgrp!(name, fix_gids[gid])
          else
            IO.puts("#{name} needs its uid changed from #{uid} to #{fix_uids[uid]}\n")
          end

          File.chown!(name, fix_uids[uid])
        else
          if Map.has_key?(fix_gids, gid) do
            IO.puts("#{name} needs its gid changed from #{gid} to #{fix_gids[gid]}\n")
            File.chgrp!(name, fix_gids[gid])
          end
        end
      end

      true
    end

    ParallelTreeWalk.procdir(path_name, major, proc_entry, filter_entry)
    ParallelTreeWalk.wait_until_finished()
  end

  def main(args \\ []) do
    try do
      [ids_file, root_directory | others] = args

      case others do
        [] ->
          get_fixes!(ids_file)
          |> procdir(root_directory)

        _ ->
          IO.puts("Error: extraneous command line arguments #{inspect(others)}")
      end
    catch
      type, value ->
        IO.puts("Error\n  #{inspect(type)}\n  #{inspect(value)}")
    end
  end

  def start(_a, _b) do
    options = [
      strategy: :one_for_one,
      name: FixId.Supervisor
    ]

    # read uid and gid fixes from a file here
    Supervisor.start_link([], options)
  end
end
