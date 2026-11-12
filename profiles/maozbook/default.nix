# MAOZBook固有のシステム設定。macOS汎用設定に、このマシンだけのCask一覧を足す。
{ ... }:
{
  imports = [ ../darwin ];

  homebrew.taps = [
    "hashicorp/tap"
    "homebrew/services"
    "jorgerojas26/lazysql"
    "k1low/tap"
    "sqldef/sqldef"
  ];

  # Nixで管理しないCLIはHomebrewのformulaで管理する
  # （依存ライブラリはHomebrewが解決するため書かない）
  homebrew.brews = [
    "bottom"
    "certbot"
    "git-filter-repo"
    "git-lfs"
    "go-task"
    "golang-migrate"
    "lazydocker"
    "macmon"
    "media-control"
    "nowplaying-cli"
    "nvm"
    "openssl@3"
    "pnpm"
    "pyenv"
    "ruff"
    "sevenzip"
    "tfenv"
    "tflint"
    "tree"
    "xcodegen"
    # サードパーティtap
    "jorgerojas26/lazysql/lazysql"
    "k1low/tap/tbls"
  ];

  # nixpkgsで配布されていないGUIアプリはHomebrewのCaskで管理する
  homebrew.casks = [
    "parsec"
    "1password"
    "raycast"
    "ghostty"
    "mactex-no-gui"
    "thunderbird"
    "gcloud-cli"
    "postman"
    "cursor"
    "zotero"
    "session-manager-plugin"
    "karabiner-elements"
    "google-chrome"
    "discord"
    "obs"
    "claude"
    "dotnet-sdk"
    "unity-cli"
    "chatgpt"
    "obsidian"
  ];
}
