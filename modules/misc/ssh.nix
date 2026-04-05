{
  flake = {
    modules.nixos.ssh =
      { lib, ... }:
      {
        config = {
          services.openssh = {
            enable = true;
            settings = {
              KbdInteractiveAuthentication = lib.mkDefault false;
              PasswordAuthentication = lib.mkDefault false;
              PermitRootLogin = lib.mkDefault "no";
            };
          };
        };
      };
  };
}
