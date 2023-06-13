{ stdenv
, lib
, ruby_3_2
, bundlerEnv
, defaultGemConfig
, dart-sass-embedded
, nodejs
}:

let
	pname = "ap5-dev";
	ruby = ruby_3_2;

	env = bundlerEnv {
		name = pname;
		inherit ruby;
		gemdir = ./.;

		gemConfig = defaultGemConfig // {
			sass-embedded = attrs: let
				inherit (lib) getExe;
			in {
				buildInputs = (attrs.buildInputs or []) ++ [
					dart-sass-embedded
				];

				patchPhase = ''
					pushd $(mktemp -d)
					mkdir sass_embedded
					ln -s -t sass_embedded ${getExe dart-sass-embedded}
					tar cf sass.tar sass_embedded
					tar_path=$(realpath sass.tar)
					popd
					cp -t . "$tar_path"
					export SASS_EMBEDDED="file://$(realpath ./sass.tar)"
				'';
			};
		};
	};

in stdenv.mkDerivation {
	inherit pname;
	version = "unstable";

	src = ./.;

	nativeBuildInputs = [
		env.wrappedRuby
		nodejs
	];

	buildPhase = ''
		${env}/bin/jekyll build --destination "$out"
	'';
}
