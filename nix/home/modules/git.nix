{ pkgs, ... }:
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
      merge.tool = "unityyamlmerge";
      "mergetool \"unityyamlmerge\"" = {
        trustExitCode = false;
        cmd = "'/Applications/Unity/Hub/Editor/6000.0.36f1/Unity.app/Contents/Tools/UnityYAMLMerge' merge -p \"$BASE\" \"$REMOTE\" \"$LOCAL\" \"$MERGED\"";
      };
      "difftool \"sourcetree\"" = {
        cmd = "opendiff \"$LOCAL\" \"$REMOTE\"";
        path = "";
      };
      "mergetool \"sourcetree\"" = {
        cmd = "/Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"";
        trustExitCode = true;
      };
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
