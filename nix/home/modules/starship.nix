# Starshipプロンプトの設定ファイルを配置する。
{ pkgs, ... }: {
    programs.starship = {
        enable = true;
        settings = builtins.fromTOML (builtins.readFile ../../../starship/starship.toml);
    };
}
