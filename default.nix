let
  pkgs = import <nixpkgs> {};

in pkgs.stdenv.mkDerivation {
  name = "hello-world";

  buildCommand = ''
    mkdir -p $out/bin

    executable=$_/$name

    cat <<EOF > $executable
    #!${pkgs.stdenv.shell}
    PATH=${with pkgs; lib.makeBinPath [ coreutils figlet lolcat ]}
    echo "hello world" | figlet | lolcat
    EOF

    chmod +x $executable
  '';
}

# So we've touched on closures and and trimmed ours back down.
# That build command is still a bit... meh.
# Let's see if we can improve this a bit more.
