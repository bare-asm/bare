{ pkgs }: {
    deps = [
        pkgs.nasm
        pkgs.bashInteractive
        pkgs.man
        pkgs.strace
        pkgs.objconv
        pkgs.hyperfine
    ];
}