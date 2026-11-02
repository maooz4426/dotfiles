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
    "act"
    "bottom"
    "certbot"
    "fd"
    "ffmpeg"
    "fzf"
    "git-filter-repo"
    "git-lfs"
    "go-task"
    "golang-migrate"
    "gopls"
    "imagemagick"
    "lazydocker"
    "lua"
    "lua-language-server"
    "macmon"
    "media-control"
    "node"
    "nowplaying-cli"
    "nvm"
    "pipx"
    "pnpm"
    "poppler"
    "protobuf"
    "protoc-gen-go"
    "protoc-gen-go-grpc"
    "pyenv"
    "python@3.12"
    "ruff"
    "sevenzip"
    "silicon"
    "switchaudio-osx"
    "tfenv"
    "tflint"
    "tree"
    "tree-sitter"
    "uv"
    "wakeonlan"
    "xcodegen"
    "yq"
    "zoxide"
    "zstd"
    # サードパーティtap
    "jorgerojas26/lazysql/lazysql"
    "k1low/tap/tbls"
    "sqldef/sqldef/mysqldef"
  ];

  # nixpkgsで配布されていないGUIアプリはHomebrewのCaskで管理する
  homebrew.casks = [
    "alt-tab"
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
