let
  pkgs = import <nixpkgs> {};

in pkgs.stdenv.mkDerivation {
  name        = "hello-world";
  buildInputs = with pkgs; [ figlet lolcat ];

  buildCommand = ''
    mkdir -p $out/bin

    executable=$_/$name

    cat <<EOF > $executable
    #!${pkgs.stdenv.shell}
    PATH=$PATH
    echo "hello world" | figlet | lolcat
    EOF

    chmod +x $executable
  '';
}

# Ok, this is slightly better! We no longer have to explicitly:
# - call for `coreutils`: stdenv includes it by default
# - specify the target system
# - specify bash as the builder (it's the default)
# - generate a file for bash to execute
#
# However! stdenv includes more than just coreutils.
# So yes, we managed to slim down the expression a bit,
# but our *closure* got bigger.
# WTH is a closure you ask? I'm glad you did!
