{ pkgs, ... }:
# home-manager programs.git オプション一覧:
# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable
{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user = {
        name = "MAOZ";
        email = "maooz4426@gmail.com";
      };
      core = {
        excludesfile = "/Users/maoz/.gitignore_global";
        editor = "nvim";
        hooksPath = "~/.config/git/hooks";
      };
      commit.template = "/Users/maoz/.stCommitMsg";
      color.status = "auto";
      "color \"status\"" = {
        added = "red";
        changed = "yellow blink";
        untracked = "yellow reverse";
        deleted = "magenta";
      };
      "color \"branch\"" = {
        current = "yellow bold";
        local = "cyan";
        remote = "red";
      };
      "color \"diff\"" = {
        new = "yellow";
        old = "red";
      };
      http.postBuffer = 524288000;
      init.defaultBranch = "main";
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };

  home.file.".config/git/hooks/pre-commit" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      ${pkgs.gitleaks}/bin/gitleaks protect --staged --redact -v
    '';
  };
}
