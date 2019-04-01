builtins.derivation {
  system  = builtins.currentSystem;
  name    = "hello-world";
  builder = "/bin/bash";

  PATH    = "/usr/bin:/bin";

  args    = [ (builtins.toFile "my-builder" ''
    cat <<EOF > $out
    #!/usr/bin/env bash
    echo "hello world"
    EOF

    chmod +x $out
  '') ];
}

# Alright! It's working! YOU SHOULD NEVER EVER DO THIS THOUGH! Why?
# We are basically using utils provided by the underlying OS.
# Why is this bad? Because impurity!
# 1) Those come with no guarantees; I'm on darwin (aka macOS) and apple is
#    known for occasionally breaking all the things without warning.
# 2) Sandboxing is currently b0rked on darwin and therefore I can't use it.
#    Had I been able to use it, I would've been. Had sandboxing been on,
#    this would've failed miserably since the whole thing would be running
#    in a chroot where `/{,usr}/bin` are not even available.
#
# kk so let's fix this...
