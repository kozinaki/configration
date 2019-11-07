with import <nixpkgs> {};

let
  # Use the let-in clause to assign the derivation to a variable
  myScript = pkgs.writeShellScriptBin "javago" ''
						out="/home/kozinaki/dvlpmnt/java"
						rm /home/kozinaki/bin/java*
						rm -rf $out
						mkdir -p $out
						tar xf jdk.tar.gz --strip 1 -C $out
						ln -s $out/bin/java /home/kozinaki/bin/java
						ln -s $out/bin/javac /home/kozinaki/bin/javac
						lib=`ls ${stdenv.glibc}/lib/ld-linux-x86-64*`
						patchelf --set-interpreter $lib $out/bin/java
						patchelf --set-interpreter $lib $out/bin/javac
						patchelf --set-rpath ${stdenv.glibc}/lib:/nix/store/iiymx8j7nlar3gc23lfkcscvr61fng8s-zlib-1.2.11/lib/:$out/lib/amd64/jli $out/bin/java
						patchelf --set-rpath ${stdenv.glibc}/lib:/nix/store/iiymx8j7nlar3gc23lfkcscvr61fng8s-zlib-1.2.11/lib/:$out/lib/amd64/jli $out/bin/javac
						'';
in
stdenv.mkDerivation rec {
  name = "java-installer";

  # Add the derivation to the PATH
  buildInputs = [ myScript ];
}
