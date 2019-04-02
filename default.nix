let
  pkgs = import <nixpkgs> {};

  dictionary = with pkgs.lib; mapAttrs' (name: value: (nameValuePair (toLower name) value)) (importJSON ./hello-world.json);

  mkI15dHelloWorld = language: greeting: pkgs.writeShellScriptBin "hello-world-${language}" ''
    PATH=${with pkgs; lib.makeBinPath [ coreutils figlet lolcat ]}
    echo "${greeting}" | figlet | lolcat
  '';

in pkgs.lib.mapAttrs mkI15dHelloWorld dictionary

# Awesome! Looks like we're IOHK ready. Internationalized and ready
# to go and cascadingly disrupt all the things!
# Or ARE WE? What about Korean, Chinese, Japanese, Russian?
# My own language (Hebrew) isn't even in the dictionary 🤨
