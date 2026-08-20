# JankyBordersサービスの有効化と設定。
# nix-darwin経由でlaunchdで起動されるため、bordersrcは読み込まれない。
# 設定はここで直接指定する。
# https://github.com/FelixKratz/JankyBorders
{...}: {
    services.jankyborders = {
        enable = true;
        style = "round";
        width = 6.0;
        hidpi = false;
        active_color = "0xc0ff00f2";
        inactive_color = "0xff0080ff";
    };
}
