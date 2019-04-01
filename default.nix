let
  builder = builtins.toFile "my-builder" ''
    mkdir -p $out/bin

    executable=$_/$name

    cat <<EOF > $executable
    #!$builder
    PATH=$PATH
    echo "hello world"
    EOF

    chmod +x $executable
  '';

  pkgs = import <nixpkgs> {};

in builtins.derivation {
  system  = builtins.currentSystem;
  name    = "hello-world";
  builder = "${pkgs.bash}/bin/bash";
  args    = [ builder ];

  PATH    = "${pkgs.coreutils}/bin";
}

# Alright! Buildable AND installable!
# We can now type `hello-world` instead of
# `echo hello world` just like we always wanted!
# Ok ok tbh this hello world is pretty sad.
# Let's spice it up a bit.
