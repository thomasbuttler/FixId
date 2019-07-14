<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="tbuttler.20190709141000.1" a="E"><vh>@clean lib/fix_id.ex</vh>
<v t="tbuttler.20190712033944.1"><vh>get_fixes! documentation</vh></v>
<v t="tbuttler.20190711193658.1"><vh>get_fixes!</vh></v>
<v t="tbuttler.20190712034208.1"><vh>procdir documentation</vh></v>
<v t="tbuttler.20190710030422.1"><vh>procdir</vh></v>
<v t="tbuttler.20190710030340.1"><vh>main</vh></v>
<v t="tbuttler.20190710134552.1"><vh>start</vh></v>
</v>
<v t="tbuttler.20190709135850.2" a="E"><vh>@clean mix.exs</vh>
<v t="tbuttler.20190709140050.1"><vh>use Mix.Project</vh></v>
<v t="tbuttler.20190709140309.1"><vh>project</vh></v>
<v t="tbuttler.20190709140104.1"><vh>application</vh></v>
<v t="tbuttler.20190709140113.1"><vh>escript</vh></v>
<v t="tbuttler.20190709140130.1"><vh>deps</vh></v>
</v>
<v t="tbuttler.20190712124300.1" a="E"><vh>@clean README.md</vh>
<v t="tbuttler.20190712124300.2"><vh>FixId</vh></v>
</v>
<v t="tbuttler.20190709143225.2"><vh>@clean rel/config.exs</vh></v>
<v t="tbuttler.20190714132638.2"><vh>@clean .travis.yml</vh></v>
<v t="tbuttler.20190714132748.1" a="E"><vh>test</vh>
<v t="tbuttler.20190714155244.1"><vh>@clean mix_environment</vh></v>
<v t="tbuttler.20190714132842.2"><vh>@clean FixId_test.exs</vh></v>
<v t="tbuttler.20190714134406.2"><vh>@clean ids_file</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="tbuttler.20190709135850.2">@language text
defmodule FixId.Mixfile do
  @others
end
</t>
<t tx="tbuttler.20190709140050.1">use Mix.Project

</t>
<t tx="tbuttler.20190709140104.1"># Configuration for the OTP application
#
# Type `mix help compile.app` for more information
def application do
  [
    mod: {FixId, []},
    applications: [:logger, :parallel_tree_walk]
  ]
end

</t>
<t tx="tbuttler.20190709140113.1">def escript do
  [
    main_module: FixId,
    emu_args: "+A32"
  ]
end

</t>
<t tx="tbuttler.20190709140130.1"># Dependencies can be Hex packages:
#
#   {:mydep, "~&gt; 0.3.0"}
#
# Or git/path repositories:
#
#   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
#
# Type `mix help deps` for more examples and options
defp deps do
  [
    {:parallel_tree_walk, git: "https://github.com/thomasbuttler/ParallelTreeWalk.git"},
    {:distillery, "~&gt; 2.0"},
    {:dialyxir, "~&gt; 0.5.0", only: [:dev], runtime: false}
  ]
end
</t>
<t tx="tbuttler.20190709140309.1">def project do
  [
    app: :fix_id,
    version: "0.0.1",
    elixir: "~&gt; 1.0",
    build_embedded: Mix.env() == :prod,
    start_permanent: Mix.env() == :prod,
    escript: escript(),
    deps: deps()
  ]
end

</t>
<t tx="tbuttler.20190709141000.1">defmodule FixId do
  use Application
  require Logger

  @moduledoc """
  Process a directory tree, changing uids and gids as specified in a mapping file
  """

  @others
end
</t>
<t tx="tbuttler.20190709143225.2">@language unknown_language
# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|&gt; Path.join()
|&gt; Path.wildcard()
|&gt; Enum.map(&amp;Code.eval_file(&amp;1))

use Distillery.Releases.Config,
    # This sets the default release built by `mix distillery.release`
    default_release: :default,
    # This sets the default environment used by `mix distillery.release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  # If you are running Phoenix, you should make sure that
  # server: true is set and the code reloader is disabled,
  # even in dev mode.
  # It is recommended that you build with MIX_ENV=prod and pass
  # the --env flag to Distillery explicitly if you want to use
  # dev mode.
  set dev_mode: true
  set include_erts: false
  set cookie: :"~[&gt;_Z(_9S/kc$4BD[IDwbzY:~erelDw`YChEwXodk.*UZ&lt;$j[JI.`BbpP:||]_VD"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"K6ThX7.CHC~J5OJ(ry]xfp_JSjeHb~e3azBh&amp;B|=/?R:9(4wzH.5?Hig~]j[gU=o"
  set vm_args: "rel/vm.args"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix distillery.release`, the first release in the file
# will be used by default

release :fix_id do
  set version: current_version(:fix_id)
  set applications: [
    :runtime_tools
  ]
end

</t>
<t tx="tbuttler.20190710030340.1">def main(args \\ []) do
  try do
    [ids_file, root_directory | others] = args

    case others do
      [] -&gt;
        get_fixes!(ids_file)
        |&gt; procdir(root_directory)

      _ -&gt;
        IO.puts("Error: extraneous command line arguments #{inspect(others)}")
    end
  catch
    type, value -&gt;
      IO.puts("Error\n  #{inspect(type)}\n  #{inspect(value)}")
  end
end

</t>
<t tx="tbuttler.20190710030422.1">@spec procdir({Map.t(), Map.t()}, String.t()) :: :ok
def procdir({fix_uids, fix_gids}, path_name) do
  {:ok, %File.Stat{major_device: major}} = File.lstat(path_name)
  # accept all
  filter_entry = fn _name -&gt; true end

  proc_entry = fn name, %File.Stat{uid: uid, gid: gid, type: type} -&gt;
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

</t>
<t tx="tbuttler.20190710134552.1">def start(_a, _b) do
  options = [
    strategy: :one_for_one,
    name: FixId.Supervisor
  ]

  # read uid and gid fixes from a file here
  Supervisor.start_link([], options)
end
</t>
<t tx="tbuttler.20190711193658.1">@spec get_fixes!(String.t()) :: {Map.t(), Map.t()}
def get_fixes!(ids_file) do
  [uids, gids, _] =
    File.stream!(ids_file)
    |&gt; Stream.map(&amp;String.split(&amp;1))
    # comment facility - ignore all but first two elements
    |&gt; Stream.map(fn
      [a, b | _] -&gt; [a, b]
      a -&gt; a
    end)
    # primitive comment facility
    |&gt; Stream.filter(fn
      ["#" | _] -&gt; false
      _ -&gt; true
    end)
    |&gt; Enum.reduce(
      [%{}, %{}, :collect_uid_mapping],
      fn
        [uid_before, uid_after], [uids, gids, :collect_uid_mapping] -&gt;
          [
            Map.put(uids, String.to_integer(uid_before), String.to_integer(uid_after)),
            gids,
            :collect_uid_mapping
          ]

        [gid_before, gid_after], [uids, gids, :collect_gid_mapping] -&gt;
          [
            uids,
            Map.put(gids, String.to_integer(gid_before), String.to_integer(gid_after)),
            :collect_gid_mapping
          ]

        ["gids" | _], [uids, gids, _] -&gt;
          [uids, gids, :collect_gid_mapping]

        ["uids" | _], [uids, gids, _] -&gt;
          [uids, gids, :collect_uid_mapping]

        _, state -&gt;
          state
      end
    )

  # sanity checks that no value of uids should appear as a key of uids,
  # and no value of gids appears as a key of gids
  Enum.each(uids, fn {_key, value} -&gt;
    uids[value] &amp;&amp; raise "Error: circular mapping in uids #{value}"
  end)

  Enum.each(gids, fn {_key, value} -&gt;
    gids[value] &amp;&amp; raise "Error: circular mapping in gids #{value}"
  end)

  {uids, gids}
end

</t>
<t tx="tbuttler.20190712033944.1">@raw
  @doc """
@end_raw
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
</t>
<t tx="tbuttler.20190712034208.1">@raw
  @doc """
@end_raw
major device numbers are unique to the file system, and minor numbers are always zero,
*except* when the file is a device (block or character).  Practically, it means we can
use a difference in the major device number of directories to identify a mount point.
"""

</t>
<t tx="tbuttler.20190712124300.1">@others
@language md
@tabwidth -4
</t>
<t tx="tbuttler.20190712124300.2">Utility to change file uids and gids within a directory tree
============================================================

This utility is intended for use with

* POSIX compatible directory trees
* input bound processing: the underying Erlang virtual machine should be invoked with something like +A32 because processing is spending its time in each of those threads idle waiting for the file server to respond.

Run with:
---------
* mix deps.get
* iex --erl +A32 -S mix
* iex(1)&gt; FixId.get_fixes("tests/ids_file") |&gt; FixId.procdir(".")
* ...or...
* mix escript.build
* ./fix_id tests/ids_file .

Test Status: [![Build Status](https://travis-ci.org/thomasbuttler/FixId.svg?branch=master)](https://travis-ci.org/thomasbuttler/FixId)

To Do:

* improve @moduledoc, @doc
* provide @spec
* write tests
* TravisCI
* Distillery config and instructions

NOTES:
------
* Unless one is doing nothing other than changing a group from one to which
the process belongs to another to which the process belongs, this will need to
run as root.
* This will not apply a chown or chgrp to a symlink: the Linux kernel ignores the permissions mode of the symlink itself (thus one does not need to change those permissions), and applying chown to the symlink changes the target of the symlink, which should have complex guardrails.

* For cosmetic purposes, it might be nice to apply chown or chgrp to a symbolic
 link, but Elixir does not support lchown
* Possible alternative:
    * capture the name of the symlink
    * capture the target of the symlink
    * recreate the symlink as root
      * linux symlink permission semantic:
        * owner, group, and mode of symlink ignored
        * permission to replace or remove symlink specified by containing directory

</t>
<t tx="tbuttler.20190714132638.2">@language yaml
service: docker
language: elixir
elixir:
  - 1.6
before_script:
  - sudo useradd -u 5000 tb0
  - sudo useradd -u 5001 tb1
  - sudo tar xvf test/test_data.tar
script:
  - sudo /bin/bash -c ". test/mix_environment; mix test"
# the awk removes:
# * "total" lines - which vary between file system types
# * sizes from directories - which vary between filesystem types
# * GNU "extra permissions" indicator (. or +) at the end of the mode line
# * the date, which tends to change ;-)
  - sudo ls -lR test/dir | awk '/^total / { next } /^d/ { $5="" } { gsub(/[.+]/,"",$1);$6=""; $7=""; $8=""; print }' | diff -b -u test/after -

</t>
<t tx="tbuttler.20190714132748.1">@path test
</t>
<t tx="tbuttler.20190714132842.2">@language unknown_language
defmodule FixIdTest do
  use ExUnit.Case

  test "run main" do
    assert FixId.main(["test/ids_file", "test/dir"]) == :ok
  end
end
</t>
<t tx="tbuttler.20190714134406.2">@language unknown_language
uids
# before after
5000 5001
gids
# before after
5000 5001

</t>
<t tx="tbuttler.20190714155244.1">export ELIXIR_VERSION=1.6
export LC_ALL=en_US.UTF-8
export MIX_ARCHIVES=/home/travis/.kiex/mix/elixir-1.6
export ANSI_RESET=\033[0m
export _KERL_SAVED_REBAR_PLT_DIR=
export Werror=format-security
export PATH=/home/travis/.kiex/elixirs/elixir-1.6/bin:/home/travis/otp/19.0/bin:/home/travis/bin:/home/travis/.local/bin:/home/travis/.kiex/elixirs/elixir-1.3.2/bin:/home/travis/.kiex/bin:$PATH
export LANG=en_US.UTF-8
export MERB_ENV=test
export TZ=UTC
export HOME=/home/travis
export ANSI_CLEAR=\033[0K
export REBAR_PLT_DIR=/home/travis/otp/19.0
export LOGNAME=travis
export LC_CTYPE=en_US.UTF-8
export _KERL_ACTIVE_DIR=/home/travis/otp/19.0
export ANSI_RED=\033[31;1m
export _KERL_MANPATH_REMOVABLE=/home/travis/otp/19.0/lib/erlang/man:/home/travis/otp/19.0/man
</t>
</tnodes>
</leo_file>
