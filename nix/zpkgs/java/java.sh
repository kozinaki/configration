#!/run/current-system/sw/bin/bash
out='/home/kozinaki/dvlpmnt/java'
mkdir -p /home/kozinaki/dvlpmnt/java
tar xf $src --strip 1 -C /home/kozinaki/dvlpmnt/java/
ln -s /home/kozinaki/dvlpmnt/java/bin/java /home/kozinaki/bin/java
a='ls /nix/store/*glibc*/lib/ld-linux-x86-64*'
patchelf --set-interpreter $a $out/bin/java
patchelf --set-interpreter $a $out/bin/javac
#patchelf --set-rpath ${stdenv.glibc}/lib:/nix/store/iiymx8j7nlar3gc23lfkcscvr61fng8s-zlib-1.2.11/lib/:$out/dvlpmnt/java/lib/jli $out/bin/java
#patchelf --set-rpath ${stdenv.glibc}/lib:/nix/store/iiymx8j7nlar3gc23lfkcscvr61fng8s-zlib-1.2.11/lib/:$out/dvlpmnt/java/lib/jli $out/bin/javac
