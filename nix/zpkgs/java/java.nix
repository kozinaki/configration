with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "java11";

  src = fetchurl {
    url = https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz;
    sha256 = "3784cfc4670f0d4c5482604c7c513beb1a92b005f569df9bf100e8bef6610f2e";
  };

  installPhase = ''
    mkdir -p $out/java
    cp -r * $out/java
    patchelf --set-interpreter ${stdenv.glibc}/lib/ld-linux-x86-64.so.2 $out/bin/java
    patchelf --set-interpreter ${stdenv.glibc}/lib/ld-linux-x86-64.so.2 $out/bin/javac
    patchelf --set-rpath ${stdenv.glibc}/lib:/nix/store/iiymx8j7nlar3gc23lfkcscvr61fng8s-zlib-1.2.11/lib/:$out/dvlpmnt/java/lib/jli $out/bin/java
    patchelf --set-rpath ${stdenv.glibc}/lib:/nix/store/iiymx8j7nlar3gc23lfkcscvr61fng8s-zlib-1.2.11/lib/:$out/dvlpmnt/java/lib/jli $out/bin/javac
  '';
}
