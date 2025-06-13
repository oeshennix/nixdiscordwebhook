{nixpkgs}:
let
  pkgs=nixpkgs;
in
pkgs.stdenv.mkDerivation{
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
}
