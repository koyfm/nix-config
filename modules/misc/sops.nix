{ inputs, ... }:
{
  flake = {
    modules.nixos.sops =
      { config, lib, ... }:
      {
        config = {
          sops = {
            defaultSopsFile = lib.mkDefault (inputs.self + "/secrets/${config.networking.hostName}.yaml");
            age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
          };
        };
      };
    modules.homeManager.sops =
      { config, lib, ... }:
      {
        config = {
          sops = {
            defaultSopsFile = lib.mkDefault (inputs.self + "/secrets/home/koi.yaml");
            age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
          };
        };
      };
  };
}
