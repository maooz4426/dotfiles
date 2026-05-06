# LaTeX 執筆環境の設定。
# - latexmkrc: lualatex でのビルド設定
# - Cursor / VS Code: LaTeX Workshop 拡張機能の設定
{ ... }:
let
  latexSettings = builtins.toJSON {
    # SyncTeX でエディタ⟷PDF 双方向ジャンプ
    "latex-workshop.view.pdf.viewer" = "tab";
    "latex-workshop.synctex.afterBuild.enabled" = true;

    # ビルドレシピ
    "latex-workshop.latex.recipes" = [
      {
        name = "lualatex";
        tools = [ "lualatex" ];
      }
      {
        name = "lualatex × biber × lualatex × lualatex";
        tools = [
          "lualatex"
          "biber"
          "lualatex"
          "lualatex"
        ];
      }
    ];

    "latex-workshop.latex.tools" = [
      {
        name = "lualatex";
        command = "latexmk";
        args = [
          "-lualatex"
          "-synctex=1"
          "-interaction=nonstopmode"
          "-file-line-error"
          "%DOC%"
        ];
      }
      {
        name = "biber";
        command = "biber";
        args = [ "%DOCFILE%" ];
      }
    ];

    # 保存時に自動ビルド
    "latex-workshop.latex.autoBuild.run" = "onSave";
    # 補助ファイルをサブディレクトリに集める
    "latex-workshop.latex.outDir" = "%DIR%/out";
  };
in
{
  home.file.".latexmkrc".text = ''
    $pdf_mode = 4;  # lualatex を使用
    $lualatex = 'lualatex -synctex=1 -interaction=nonstopmode %O %S';
    $clean_full_ext = 'synctex.gz';
  '';

  # Cursor の LaTeX Workshop 設定
  home.file."Library/Application Support/Cursor/User/settings.json".text = latexSettings;

  # VS Code の LaTeX Workshop 設定
  home.file."Library/Application Support/Code/User/settings.json".text = latexSettings;
}
