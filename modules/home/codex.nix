# Codex CLIのグローバル設定。
# AGENTS.mdは~/.codex、スキルは~/.agents/skills（Codexのユーザースキル置き場）にリンクする。
# 実体はdotfiles/config/codexに置く。
#
# ~/.codex/config.tomlはCodexが実行時に書き換える（projectsのtrust、plugins、MCP）ため、
# リンクしない。
# メトリクス送信の設定（otel.toml）は、[otel]テーブルがないときだけ追記する。
# otel.tomlを変更したら、~/.codex/config.tomlの[otel]テーブルも編集または削除する。
{ config, lib, dotfilesDir, ... }:
let
  codexDir = "${dotfilesDir}/config/codex";
in
{
  home.file = {
    ".codex/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${codexDir}/AGENTS.md";
    ".agents/skills/search".source = config.lib.file.mkOutOfStoreSymlink "${codexDir}/skills/search";
    ".agents/skills/code-review".source = config.lib.file.mkOutOfStoreSymlink "${codexDir}/skills/code-review";
  };

  home.activation.codexOtel = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    codexConfig="$HOME/.codex/config.toml"
    if ! grep -qs '^\[otel[].]' "$codexConfig"; then
      run mkdir -p "$HOME/.codex"
      run sh -c 'umask 077; { echo; cat "$1"; } >> "$2"' _ "${codexDir}/otel.toml" "$codexConfig"
    fi
  '';
}
