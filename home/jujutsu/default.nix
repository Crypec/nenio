{pkgs, ...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "jj@ctx.dev";
        name = ".ctx";
      };
      ui = {
        diff.tool = ["difft" "--color=always" "$left" "$right"];
      };
    };
  };

  home.packages = with pkgs; [
    difftastic
  ];
}
