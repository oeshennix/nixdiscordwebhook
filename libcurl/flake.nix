{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs}: {

    packages.x86_64-linux.default = let
      pkgs = import nixpkgs { system="x86_64-linux";};
    in pkgs.stdenv.mkDerivation{
      buildInputs= with pkgs; [openssl libpsl perl];
      src = pkgs.fetchurl {
        url = "https://curl.se/download/curl-8.14.1.tar.gz";
        hash = "sha256-Z2atpxAdKStCuLFWgRIKzWjv+kqWYJNYU89tYfDZhNQ=";
      };
      name="libcurl";
      configurePhase=''
        ./configure --with-openssl --disable-docs --with-gnutls --prefix=$out;
      '';
      buildPhase=''
        export perl=${pkgs.perl}
        ls scripts
        make
      '';
      fixupPhase="";
      installPhase=''
        make install
      '';
    };
  };
}
