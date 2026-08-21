# MAOZBook固有のhome-manager設定。
# macOS汎用設定（profiles/darwin/home.nix）に、この機材だけの開発環境を足す。
{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [ ../darwin/home.nix ];

  home.packages = [
    pkgs.nerd-fonts.hack # Hack Nerd Font
    pkgs.mosh # モバイル向けSSHクライアント
    pkgs.mariadb.client # MySQLクライアント（CLIのみ）
    pkgs.maven # Javaビルドツール
    pkgs.golangci-lint
    pkgs.sops
    pkgs.postgresql # psqlクライアントCLI（サーバーは含まない）
    pkgs.ansible
    pkgs.kubectl # Kubernetes CLI
    pkgs.k9s # Kubernetes TUI
    pkgs.kubernetes-helm # helm
    pkgs.argocd # Argo CD CLI
    pkgs.pinact
    pkgs.cloudflared
    pkgs.ghc # Haskellコンパイラ
    pkgs.cabal-install # Haskellビルドツール
    pkgs.hlint # Haskellリンタ
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  # macOS固有のgit設定（Linuxホストには存在しないパスのため共通モジュールには置かない）
  programs.git.settings = {
    core.excludesfile = "${config.home.homeDirectory}/.gitignore_global";
    commit.template = "${config.home.homeDirectory}/.stCommitMsg";
  };

  # macOS固有のzsh初期化（Homebrew版のnvm/rbenv/pyenv等）
  programs.zsh.sessionVariables = {
    PYENV_ROOT = "$HOME/.pyenv";
  };

  programs.zsh.initContent = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export JAVA_HOME="${pkgs.jdk21.home}"

    # タイトルバー
    precmd() { print -Pn "\e]0;%~\a" }

    # nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

    # rbenv
    eval "$(rbenv init - zsh)"

    # pyenv
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # cargo
    [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
  '';

  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/.rbenv/bin"
    "$HOME/.yarn/bin"
    "/opt/homebrew/opt/mysql-client/bin"
  ];
}
