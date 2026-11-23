{ config, ... }:
{
  sops.secrets."koi-smbpasswd" = { };

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
        "valid users" = "koi";
        "force user" = "koi";
        "force group" = "users";
        "create mask" = "0664";
        "directory mask" = "2775";
      };
    };
  };

  systemd.services = {
    samba-smbd = {
      requires = [ "mnt-storage.mount" ];
      after = [ "mnt-storage.mount" ];
    };

    samba-koi-password = {
      wantedBy = [ "samba-smbd.service" ];
      before = [ "samba-smbd.service" ];
      after = [ "systemd-tmpfiles-setup.service" ];
      restartTriggers = [ config.sops.secrets."koi-smbpasswd".sopsFile ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        pw=$(cat ${config.sops.secrets."koi-smbpasswd".path})
        printf '%s\n%s\n' "$pw" "$pw" | ${config.services.samba.package}/bin/smbpasswd -s -a koi
      '';
    };
  };
}
