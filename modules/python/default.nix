{ pkgs, ... }: {
  environment.systemPackages = [
    (
      let
        python-packages = packages: [
          packages.black
        ] ++ packages.black.optional-dependencies.d;
      in
      pkgs.python3.withPackages python-packages
    )
  ];
}
