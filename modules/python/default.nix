{ lib, host, pkgs, ... }: {
  environment.systemPackages = [
    (
      let
        packages = packages: [
          packages.black
        ] ++ packages.black.optional-dependencies.d ++ (lib.optionals (host ? hasCuda) [
          packages.torchWithCuda
        ]);
      in
      pkgs.python3.withPackages packages
    )
  ];
}
