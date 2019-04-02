let
  pkgs = import <nixpkgs> {};

in pkgs.writeShellScriptBin "hello-world" ''
  PATH=${with pkgs; lib.makeBinPath [ coreutils figlet lolcat ]}
  echo "hello world" | figlet | lolcat
''

# Whoa! Not so ugly anymore! Let's push the envelope a little further.
