{ pkgs, flakes, system, ... }:

let
	pkg = pkgs.callPackage ./default.nix { };
in
	pkg.overrideAttrs (attrs: {
		nativeBuildInputs = (attrs.nativeBuildInputs or []) ++ [
			pkgs.bundix
		];
	})
