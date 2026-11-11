{
  dbus,
  fetchFromGitHub,
  lib,
  makeWrapper,
  nix-update-script,
  pkg-config,
  rustPlatform,
  udev,
  udevCheckHook,
  versionCheckHook,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "hyper-headset";
  version = "1.10.1";

  src = fetchFromGitHub {
    owner = "LennardKittner";
    repo = "HyperHeadset";
    tag = "v${finalAttrs.version}";
    hash = "sha256-NAuPEaB3DRafrg9yDkrcXEm8Ipa49yKB9uPnrlewiOQ=";
  };

  cargoHash = "sha256-SsQkhM5ydzSAojnBEpESnNgjVUSJYZXadLObd8wLc6g=";

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    dbus
    udev
  ];

  buildFeatures = [ "eq-editor" ];

  cargoBuildFlags = [
    "--bin"
    "hyper_headset"
    "--bin"
    "hyper_headset_cli"
  ];

  postPatch = ''
    substituteInPlace 99-HyperHeadset.rules \
      --replace-fail 'MODE="0666"' 'TAG+="uaccess"'
  '';

  postInstall = ''
    install -Dm644 99-HyperHeadset.rules $out/lib/udev/rules.d/60-hyper-headset.rules
    install -Dm644 hyper-headset.desktop -t $out/share/applications

    for bin in hyper_headset hyper_headset_cli; do
      wrapProgram $out/bin/$bin --set-default HYPERHEADSET_NO_AUTO_UDEV 1
    done
  '';

  nativeInstallCheckInputs = [
    versionCheckHook
    udevCheckHook
  ];
  doInstallCheck = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "CLI and tray application for monitoring and managing HyperX headsets";
    homepage = "https://github.com/LennardKittner/HyperHeadset";
    changelog = "https://github.com/LennardKittner/HyperHeadset/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "hyper_headset";
    platforms = lib.platforms.linux;
  };
})
