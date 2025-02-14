{ lib, functions, host, pkgs, ... }: {
  environment.systemPackages = [
    (
      let
        packages = packages: (
          functions.readAttributes lib ./packages.txt packages
        ) ++ packages.black.optional-dependencies.d ++ (lib.optionals (host ? hasCuda) [
          packages.torchWithCuda
        ]);
      in
      pkgs.python3.withPackages packages
    )
  ];
}
