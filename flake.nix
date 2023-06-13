{
	description = "ap5.dev personal website";

	inputs = {
		# nixpkgs.url = github:nixos/nixpkgs;
	};

	outputs = { self
		, nixpkgs
		, ...
	}@flakes: let
		# compose : (b -> c) -> (a -> b) -> a -> c
		compose = f: g: x: f (g x);

		# forEachSystem : (Str -> Set Any) -> Set (Set Any);
		forEachSystem = with nixpkgs.lib; genAttrs systems.flakeExposed;

		# mkWithEnv : (Str -> Set Any) -> (Set Any -> Set Any) -> Set Any
		mkWithEnv = envFn: fn: system: let
			env = { inherit system; } // (envFn system);
		in
			fn env;

		# eachSystemEnv : (Set Any -> Set Any) -> Set (Set Any)
		eachSystemEnv = compose forEachSystem (mkWithEnv (system: {
			pkgs = nixpkgs.legacyPackages.${system};
		}));
		
		# pkgName : Str
		pkgName = "ap5-dev";
	in {
		packages = eachSystemEnv (env: with env; rec {
			ap5-dev = pkgs.callPackage ./default.nix { };
			default = ap5-dev;
		});

		devShells = eachSystemEnv (env: with env; rec {
			ap5-dev = import ./shell.nix { inherit pkgs flakes system; };
			default = ap5-dev;
		});

		apps = eachSystemEnv (env: with env; let
			update-deps = pkgs.writeShellApplication {
				name = "update-deps";
				runtimeInputs = with pkgs; [ bundler bundix ];

				text = ''
					rm -f Gemfile.lock

					bundle lock \
						--add-platform ruby \
						--remove-platform x86_64-linux \
					|| bundle lock \
						--add-platform ruby

					bundix
				'';
			};
		in {
			update-deps = {
				type = "app";
				program = nixpkgs.lib.getExe update-deps;
			};
		});
	};
}
