{ config, ... }:
{
  sops.secrets."media-smb-password" = { };

  users.groups.media = { };
  users.users.media = {
    isSystemUser = true;
    group = "media";
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    nmbd.enable = false;
    settings = {
      global = {
        "security" = "user";
        "server min protocol" = "SMB3_11";
        "server smb encrypt" = "required";
        "hosts allow" = "192.168. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "map to guest" = "never";
      };
      data = {
        "path" = "/mnt/storage/data";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "media";
        "force user" = "media";
        "force group" = "media";
        "create mask" = "0664";
        "directory mask" = "2775";
      };
    };
  };

  systemd.services.samba-smbd = {
    requires = [ "mnt-storage.mount" ];
    after = [ "mnt-storage.mount" ];
  };

  system.activationScripts.samba-media-password = {
    deps = [ "setupSecrets" ];
    text = ''
      pw=$(cat ${config.sops.secrets."media-smb-password".path})
      printf '%s\n%s\n' "$pw" "$pw" | ${config.services.samba.package}/bin/smbpasswd -s -a media
    '';
  };
}
