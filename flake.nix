{
  description = "Nix for macOS configuration";

  # nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of
  # the flake, Each item in `inputs` will be passed as a parameter to the
  # `outputs` function after being pulled and built.

  inputs = {
    # set nix-darwin channel
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";

      # The `follows` keyword in inputs is used for inheritance. Here,
      # `inputs.nixpkgs` of home-manager is kept consistent with the
      # `inputs.nixpkgs` of the current flake, to avoid problems caused by
      # different versions of nixpkgs dependencies.

      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  # The `outputs` function will return all the build results of the flake. A
  # flake can have many use cases and different types of outputs, parameters in
  # `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the
  # `outputs` itself (self-reference) The `@` syntax here is used to alias the
  # attribute set of the inputs's parameter, making it convenient to use inside
  # the function.

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    # nix-darwin and home-manager require users, hostnames, and other
    # configurations to be set declaratively. This flake is written to pass
    # some of these arguments down to the nix-darwin and home-manager modules.
    # Set them here now.
    username = "eweix";
    useremail = "elliott@weix.us";
    system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
    hostname = "nightjar";

    specialArgs =
      inputs
      // {
        inherit username useremail hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;

      # the nix flake is broken up into multiple modules in ./modules for
      # organization. These modules are passed to flake.nix here.
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix

        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ./home;
        }
      ];
    };

    # nix code formatter
    # formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
