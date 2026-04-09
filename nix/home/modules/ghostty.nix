# Ghosttyターミナルの設定ファイルを配置する。
{ ... }: {
    home.file."Library/Application Support/com.mitchellh.ghostty/config" = {
        source = ../../../ghostty/config;
    };
}
