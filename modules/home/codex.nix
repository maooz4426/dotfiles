# Codex CLIのグローバル設定。
# AGENTS.mdは~/.codex、スキルは~/.agents/skills（Codexのユーザースキル置き場）にリンクする。
# 実体はdotfiles/config/codexに置く。
#
# ~/.codex/config.tomlはCodexが実行時に書き換える（projectsのtrust、plugins、MCP）ため、
# リンクしない。
{ config, dotfilesDir, ... }:
let
  codexDir = "${dotfilesDir}/config/codex";
in
{
  home.file = {
    ".codex/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${codexDir}/AGENTS.md";
    ".agents/skills/search".source = config.lib.file.mkOutOfStoreSymlink "${codexDir}/skills/search";
    ".agents/skills/code-review".source = config.lib.file.mkOutOfStoreSymlink "${codexDir}/skills/code-review";
  };
}
