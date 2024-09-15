{pkgs, config, ...}:
{
  programs.git = {
      enable = true;
      ignores = [
        "result"
        "result-*"
      ];
      extraConfig = {
        commit.verbose = true;
        pull.rebase = true;
        init.defaultBranch = "main";
      };
    };
}
