# Claude Codeのグローバル設定（~/.claude）。
# CLAUDE.md/settings.json/skills等の実体はdotfiles/config/claudeに置き、
# ~/.claude側はファイル/ディレクトリ単位のシンボリックリンクにする。
# ~/.claude/projects等のランタイムデータはリンクせず、実ディレクトリのまま残す。
#
# skills/ 全体をリンクしないのは、skills/synced/ がClaude Code実行中に
# 自動同期で書き込まれるランタイム領域で、skills/ ごとリンクすると衝突するため。
# 追跡対象のスキルディレクトリを追加したら、ここにも追記する。
{ config, dotfilesDir, ... }:
let
  claudeDir = "${dotfilesDir}/config/claude";
in
{
  home.file = {
    ".claude/.gitignore".source = config.lib.file.mkOutOfStoreSymlink "${claudeDir}/.gitignore";
    ".claude/.github".source = config.lib.file.mkOutOfStoreSymlink "${claudeDir}/.github";
    ".claude/README.md".source = config.lib.file.mkOutOfStoreSymlink "${claudeDir}/README.md";
    ".claude/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${claudeDir}/settings.json";
    ".claude/skills/pr".source = config.lib.file.mkOutOfStoreSymlink "${claudeDir}/skills/pr";
    ".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink "${claudeDir}/CLAUDE.md";
  };
}
