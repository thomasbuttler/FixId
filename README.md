Utility to change file uids and gids within a directory tree
============================================================

This utility is intended for use with

* POSIX compatible directory trees
* input bound processing: the underying Erlang virtual machine should be invoked with something like +A32 because processing is spending its time in each of those threads idle waiting for the file server to respond.

Run with:
---------
* mix deps.get
* iex --erl +A32 -S mix
* iex(1)> FixId.get_fixes("tests/ids_file") |> FixId.procdir(".")
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

