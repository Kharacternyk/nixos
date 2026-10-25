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

          ${lib.getExe' pkgs.coreutils "ln"} -sfT "$next" /tmp/nixos-next
        ''
      )
      (
        pkgs.writeScriptBin "audit" ''
          #!${lib.getExe pkgs.bash} -p
          set -euo pipefail

          next="$(${lib.getExe' pkgs.coreutils "readlink"} -e -- /tmp/nixos-next)"
          [[ $next =~ ^/nix/store/[^/]+$ && -d $next ]]
          ${lib.getExe' pkgs.nix "nix-store"} --check-validity "$next"

          ${lib.getExe' pkgs.systemd "run0"} ${lib.getExe' pkgs.coreutils "ln"} -sfT \
            "$next" /nix/var/nix/gcroots/nixos-next

          ${lib.getExe pkgs.difftastic} /etc/nixos /nix/var/nix/gcroots/nixos-next
          ${lib.getExe' pkgs.diffutils "diff"} -rN /etc/nixos /nix/var/nix/gcroots/nixos-next
        ''
      )
      (
        pkgs.writeScriptBin "rebuild" ''
          #!${lib.getExe pkgs.bash} -p

          ${lib.getExe pkgs.nixos-rebuild-ng} --flake /nix/var/nix/gcroots/nixos-next \
            --elevate run0 "$@"
        ''
      )
    ];
  };
}
