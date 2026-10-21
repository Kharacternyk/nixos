{ lib, pkgs, self, ... }: {
  environment = {
    etc.nixos.source = self.outPath;
    systemPackages = [
      (
        pkgs.writeScriptBin "submit" ''
          #!${lib.getExe pkgs.bash} -p
          set -euo pipefail

          next="$(
            ${lib.getExe pkgs.nix} flake metadata --json . \
            | ${lib.getExe pkgs.jq} -r .path
          )"

          ${pkgs.coreutils}/bin/ln -sfT "$next" /tmp/nixos-next
        ''
      )
      (
        pkgs.writeScriptBin "audit" ''
          #!${lib.getExe pkgs.bash} -p
          set -euo pipefail

          next="$(${pkgs.coreutils}/bin/readlink -e -- /tmp/nixos-next)"
          [[ $next =~ ^/nix/store/[^/]+$ && -d $next ]]
          ${pkgs.nix}/bin/nix-store --check-validity "$next"

          ${pkgs.systemd}/bin/run0 ${pkgs.coreutils}/bin/ln -sfT \
            "$next" /nix/var/nix/gcroots/nixos-next

          ${lib.getExe pkgs.difftastic} /etc/nixos /nix/var/nix/gcroots/nixos-next
          ${pkgs.diffutils}/bin/diff -rN /etc/nixos /nix/var/nix/gcroots/nixos-next
        ''
      )
      (
        pkgs.writeScriptBin "switch" ''
          #!${lib.getExe pkgs.bash} -p

          ${lib.getExe pkgs.nixos-rebuild-ng} --flake /nix/var/nix/gcroots/nixos-next \
            --elevate run0 switch
        ''
      )
    ];
  };
}
