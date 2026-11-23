{ config, pkgs, ... }:
{
  # nixpkgs.config.rocmSupport = true;

  networking.firewall.allowedTCPPorts = [
    49374 # opencode
  ];

  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-vulkan;
    settings = {
      host = "0.0.0.0";
      port = 11435;
      models-preset = "${./models-preset.ini}";
    };
  };

  home-manager.users.koi.programs = {
    opencode.settings.server.hostname = "0.0.0.0";

    pi-coding-agent = {
      settings = {
        defaultProvider = "llamacpp";
        defaultModel = "Qwen3.8-27B";
        compaction.modelOverrides."llamacpp/Qwen3.8-27B" = {
          reserveTokens = 8192;
          keepRecentTokens = 8192;
        };
      };
      models.providers.llamacpp = {
        baseUrl = "http://localhost:${toString config.services.llama-cpp.settings.port}/v1";
        api = "openai-completions";
        apiKey = "none";
        models = [
          {
            id = "Qwen3.8-27B";
            name = "Qwen3.8 27B (local)";
            reasoning = true;
            input = [
              "text"
              "image"
            ];
            contextWindow = 32768;
            maxTokens = 8192;
            cost = {
              input = 0.15;
              output = 1.875;
              cacheRead = 0.0375;
              cacheWrite = 0;
            };
          }
        ];
      };
    };
  };
}
