---
title: Bootstrapping Rails on NixOS
author: Anna
date: 2023-01-03T22:59:27-06:00
tags: software

license: CC BY-SA 4.0
---

recently tried to start a Rails project on NixOS, realized that there was no obvious way to start a new one, even though it seemed fairly straightforward to work on an existing project.

i figured out a fairly simple process. i use direnv and flakes, and this process does too.

first, create a project directory. enter it. create the following two files to set up a trivial flake:

{% codefile flake.nix %}
```nix
{
    description = "TODO";

    inputs.flake-utils.url = github:numtide/flake-utils;

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            packages.default = pkgs.callPackage ./default.nix;
        });
}
```
{% endcodefile %}

{% codefile default.nix %}
```nix
{ stdenv, ruby_3_1 }:

stdenv.mkDerivation {
    pname = "TODO";
    version = "TODO";

    nativeBuildInputs = [];
    buildInputs = [ ruby_3_1 ];
}
```
{% endcodefile %}

then, create an .envrc with the following content:

{% codefile .envrc %}
```
use flake
layout ruby
```
{% endcodefile %}

run `direnv allow`.

next, write a bootstrap Gemfile:

{% codefile Gemfile %}
```ruby
source 'https://rubygems.org'

gem 'rails'
```
{% endcodefile %}

install locally by running `bundle install --path=vendor` (ignore the warnings for now)

finally, run `bundle exec rails install .` and, when asked, overwrite the bootstrap gemfile with the upstream default.
