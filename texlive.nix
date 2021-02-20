{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        (texlive.combine {
            inherit (texlive)
            appendixnumberbeamer
            beamertheme-focus
            catchfile
            framed
            fvextra
            minted
            scheme-medium
            upquote
            xstring
        ;})
    ];
}
