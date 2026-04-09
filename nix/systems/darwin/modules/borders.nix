# JankyBordersによるウィンドウ枠の設定。
# https://github.com/FelixKratz/JankyBorders
{...}: {
    services.jankyborders = {
        enable = true;
        style = "round";
        width = 4.0;
        hidpi = true;
        active_color = "0xc0ff00f2";   # マゼンタ（半透明）
        inactive_color = "0xff0080ff"; # ブルー
    };
}
