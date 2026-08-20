# MAOZBook固有のシステム設定。macOS汎用設定に、このマシンだけのCask一覧を足す。
{ ... }:
{
  imports = [ ../darwin ];

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
  ];
}
