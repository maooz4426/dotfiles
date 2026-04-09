# Starshipプロンプトの設定ファイルを配置する。
{ ... }: {
    xdg.configFile."starship.toml" = {
        source = ../../../starship/starship.toml;
    };
}
