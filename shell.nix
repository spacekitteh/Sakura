{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7102" }:
let
  inherit (nixpkgs) pkgs;
  ghc = pkgs.haskell.packages.${compiler}.ghcWithPackages (ps: with ps; 
[ ghc-mod mtl lens parsec QuickCheck ansi-wl-pprint text text-format annotated-wl-pprint cabal-install
alex zippers compdata
happy monad-logger hlint unordered-containers ekg haskeline 
smartcheck sbv tasty optparse-applicative configurator 
leksah data-category
#megaparsec
structured-haskell-mode]);
  texlive = pkgs.texLiveFull;
   
 
  emacsWithMyPackages = pkgs.emacsWithPackages.override {
      emacs = pkgs.emacs.override { withGTK2 = true; withGTK3 = false; }; }
        (with pkgs.emacsPackagesNg;
          [ ghc-mod
            haskell-mode
            structured-haskell-mode
            rainbow-delimiters
            company-ghc
            flycheck-haskell
            org-plus-contrib
            org-trello            
            magit ]);
  llvm = pkgs.llvm_35;
  polly = pkgs.llvmPackages_35.polly;
  git = pkgs.git;
  z3 = pkgs.z3;
  cabal2nix = pkgs.cabal2nix;
  coq = pkgs.coq_8_5;
  coqPackages = pkgs.coqPackages_8_5;
  busybox = pkgs.busybox;
  openssl = pkgs.openssl;
in
pkgs.stdenv.mkDerivation {
  name = "haskell-env-1";
  buildInputs = [ghc
  texlive
  emacsWithMyPackages
  llvm
  polly
  git
  z3
  cabal2nix
  busybox
  openssl
  coqPackages.coq
  coqPackages.mathcomp
  coqPackages.ssreflect
  ];
  
  shellHook = "eval $(egrep ^export ${ghc}/bin/ghc)";
}
