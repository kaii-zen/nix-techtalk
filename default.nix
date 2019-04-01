builtins.derivation {
  system  = builtins.currentSystem;
  name    = "hello-world";
  builder = "/bin/bash";
  args    = [ (builtins.toFile "my-builder" ''
    cat <<EOF > $out
    #!/usr/bin/env bash
    echo "hello world"
    EOF

    chmod +x $out
  '') ];
}

# This still fails to realize. Why?
# Because the build environment of a Nix derivation is sanitized. i.e.,
# the environment is cleared and PATH is empty.
# Let's fix this...
