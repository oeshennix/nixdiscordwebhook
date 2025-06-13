{
  description = "discordbot";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    libcurl.url = ./libcurl;
  };

  outputs = { self, nixpkgs, libcurl}: {
    packages.x86_64-linux.default = let
      pkgs = import nixpkgs {system="x86_64-linux";};
      a = import libcurl {nixpkgs=pkgs;};
    in pkgs.stdenv.mkDerivation {
      #nativebuildInputs=with pkgs; [openssl wget];
      buildInputs=with pkgs; [openssl wget];
      name="oceanbot";
      src=./src;
      buildPhase=''
        ls
        export flags="-I ${a}/include -L${a}/lib"
        make
      '';
      installPhase=''
        mkdir  $out
        mv cacert.pem $out
        mv request.out $out
      '';
    };

  };
}
