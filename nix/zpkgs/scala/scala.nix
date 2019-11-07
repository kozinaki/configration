with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "scala";

  src = fetchurl {
    url = https://downloads.lightbend.com/scala/2.12.8/scala-2.12.8.tgz;
    sha256 = "18w0vdbsp0q5rxglgalwlgkggld926bqi1fxc598rn4gh46a03j4";
  };

  phases = "installPhase postPhase";

  installPhase = ''
   mkdir -p $out/
   cp -r * $out/
   ${pkgs.gnutar}/bin/tar xf $src --strip 1 -C $out/
  # ln -s $out/bin/scalac /home/kozinaki/bin/scalac
  # patchelf --set-interpreter ${stdenv.glibc}/lib/ld-linux-x86-64.so.2 $out/dvlpmnt/java/bin/java
  # patchelf --set-interpreter ${stdenv.glibc}/lib/ld-linux-x86-64.so.2 $out/dvlpmnt/java/bin/javac
  # patchelf --set-rpath ${stdenv.glibc}/lib:/nix/store/iiymx8j7nlar3gc23lfkcscvr61fng8s-zlib-1.2.11/lib/:$out/dvlpmnt/java/lib/jli $out/dvlpmnt/java/bin/java
  # patchelf --set-rpath ${stdenv.glibc}/lib:/nix/store/iiymx8j7nlar3gc23lfkcscvr61fng8s-zlib-1.2.11/lib/:$out/dvlpmnt/java/lib/jli $out/dvlpmnt/java/bin/javac
  '';

  postPhase = ''
   ln -s $out/bin/scala /home/kozinaki/bin/scala
 '';
}
