let
  pkgs = import <nixpkgs> {};

  dictionary = with pkgs.lib; mapAttrs' (name: value: (nameValuePair (toLower name) value)) (importJSON ./hello-world.json);

  mkI15dHelloWorld = language: greeting: pkgs.writeShellScriptBin "hello-world-${language}" ''
    set -eo pipefail
    PATH=${with pkgs; lib.makeBinPath [ coreutils imagemagick imgcat ]}
    export FONTCONFIG_FILE=${pkgs.makeFontsConf {
      fontDirectories = [ pkgs.unifont ];
    }}
    convert -background none -fill white -font Unifont -pointsize 144 label:"${greeting}" png:- | imgcat
  '';

in pkgs.lib.mapAttrs mkI15dHelloWorld dictionary

# Ok! So now we support everyone!
# But alas... we lost the pretty colors.
# Hopefully that leaves something for next time!
