{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };
  outputs = inputs @ { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          gtkwave
          python3
          python3Packages.numpy
          python3Packages.pip
          python3Packages.scipy
          verible
          verilator
          verilog
          yosys
        ];
        runScript = "bash";
        shellHook = ''
          # Allow the use of wheels.
          SOURCE_DATE_EPOCH=$(date +%s)
          # Augment the dynamic linker path
          # Setup the virtual environment if it doesn't already exist.
          VENV=.venv
          if test ! -d $VENV; then
            python3 -m venv $VENV
          fi
          source ./$VENV/bin/activate
          pip install teroshdl pyDigitalWaveTools
        '';
      };
    };
}
