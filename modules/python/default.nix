{ lib, functions, host, pkgs, ... }: {
  environment.systemPackages = [
    (
      let
        packages = packages: (
          functions.readAttributes lib ./packages.txt packages
        ) ++  (lib.optionals (host ? hasCuda) [
          packages.torchWithCuda
          (
            packages.torchvision.override {
              torch = packages.torchWithCuda;
            }
          )
        ]);
      in
      pkgs.python3.withPackages packages
    )
  ];
}
