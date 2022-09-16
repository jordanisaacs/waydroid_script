{
  description = "Script to add gapps and other stuff to waydroid";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    pythonPackages = python-packages:
      with python-packages; [
        tqdm
        requests
      ];
    myPython = pkgs.python310.withPackages pythonPackages;
  in {
    devShells."x86_64-linux".default = pkgs.mkShell {
      buildInputs = with pkgs; [
        myPython
        lzip
        sqlite
      ];
      shellHook = ''
        PYTHONPATH=${myPython}/${myPython}
      '';
    };
  };
}
