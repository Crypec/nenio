{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];
  nix-mineral = {
    enable = false;
    overrides = {
      compatibility = {
        allow-unsigned-modules = false;
        allow-binfmt-misc = false;
      };
      desktop = {
        doas-sudo-wrapper = false;
        disable-usbguard = true;
      };
      performance = {
        allow-smt = true;
        iommu-passthrough = true;
      };
      security = {
        minimize-swapping = false;
      };
      software-choice = {
        doas-no-sudo = false;
        use-hardened-kernel = false;
        no-firewall = true;
        secure-chrony = false;
      };
    };
  };
}
