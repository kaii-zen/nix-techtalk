let
  builder = builtins.toFile "my-builder" ''
    mkdir -p $out/bin

    executable=$_/$name

    cat <<EOF > $executable
    #!$builder
    PATH=$PATH
    echo "hello world" | figlet | lolcat
    EOF

    chmod +x $executable
  '';

  pkgs = import <nixpkgs> {};

in builtins.derivation {
  system  = builtins.currentSystem;
  name    = "hello-world";
  builder = "${pkgs.bash}/bin/bash";
  args    = [ builder ];

  PATH    = with pkgs; "${coreutils}/bin:${figlet}/bin:${lolcat}/bin";
}

# Much better! Pretty isn't it?
# Too bad we can't say that about this expression...
# Let's see if we can do something about that...
