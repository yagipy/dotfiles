{
  inputs = {
    sub_flake.url = "path:./sub";
  };
  outputs = { sub_flake, ... }: {
    hello = "Hello, world!";
    sum_1_2 = sub_flake.add_a_b 1 2;
  };
}

# nix eval .#hello
# nix eval .#sum_1_2
