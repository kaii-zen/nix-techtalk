let
  builder = builtins.toFile "my-builder" ''
    cat <<EOF > $out
    #!$builder
    PATH=$PATH
    echo "hello world"
    EOF

    chmod +x $out
  '';

  pkgs = import <nixpkgs> {};

in builtins.derivation {
  system  = builtins.currentSystem;
  name    = "hello-world";
  builder = "${pkgs.bash}/bin/bash";
  args    = [ builder ];

  PATH    = "${pkgs.coreutils}/bin";
}

# Much better! Everything is nice and pure!
# Time to install our package (hint: it ain't gonna work 🙃 )
