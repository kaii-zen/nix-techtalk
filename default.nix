builtins.derivation {
  system  = builtins.currentSystem;
  name    = "hello-world";
  builder = "/bin/echo";
  args    = [ "hello world" ];
}

# This won't "build". Or in Nix parlance, it would fail to realize. Why?
