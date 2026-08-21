# LSP・補完・フォーマッタ。nixCats版 nvim/lua/plugins/lsp/ の移植。
#
# lsp.servers.<name>.enable = true にすると、対応するNixパッケージが
# 自動でPATHへ追加される（nixvimのplugins/lsp/servers/packages.nixが
# サーバ名→nixpkgs属性名の対応表を持つ）。そのため cli.nix や
# profiles/maozbook/home.nix と違い、ここではLSPバイナリを手で
# extraPackages に足す必要がない。
{ pkgs, lib, ... }:
{
  lsp.servers = {
    # 全サーバ共通のcapabilities（nvim-cmpの補完対応を有効化）
    "*".config.capabilities = lib.nixvim.mkRaw "require('cmp_nvim_lsp').default_capabilities()";

    lua_ls.enable = true;
    ts_ls.enable = true;
    gopls.enable = true;
    nil_ls.enable = true;
    terraformls.enable = true;
    jdtls.enable = true;
    helm_ls.enable = true;
    hls.enable = true;

    clangd = {
      enable = true;
      # macOSではNixのラッパーがCPLUS_INCLUDE_PATHを汚染するため、query-driverで回避
      config = lib.optionalAttrs pkgs.stdenv.isDarwin {
        cmd = [
          "clangd"
          "--query-driver=/usr/bin/clang++"
        ];
      };
    };

    omnisharp = {
      enable = true;
      config = {
        cmd = [
          "OmniSharp"
          "--languageserver"
          "--hostPID"
          (lib.nixvim.mkRaw "tostring(vim.fn.getpid())")
        ];
        settings = {
          FormattingOptions.EnableEditorConfigSupport = true;
          RoslynExtensionsOptions.EnableAnalyzersSupport = true;
        };
      };
    };

    # gh_actions_ls: nixpkgsに対応パッケージが無い（nixvimのunpackagedサーバ一覧に含まれる）。
    # 有効化しても gh-actions-language-server がPATHに無ければアタッチしない。
    # 手動でnpm等から用意する場合は `lsp.servers.gh_actions_ls = { enable = true; package = <derivation>; };` を足す。
  };

  lsp.keymaps = [
    {
      key = "gd";
      lspBufAction = "definition";
      options.silent = true;
    }
    {
      key = "K";
      lspBufAction = "hover";
      options.silent = true;
    }
    {
      key = "<leader>rn";
      lspBufAction = "rename";
      options.silent = true;
    }
    {
      key = "<leader>ca";
      lspBufAction = "code_action";
      options.silent = true;
    }
    {
      key = "gr";
      lspBufAction = "references";
      options.silent = true;
    }
  ];

  plugins.luasnip.enable = true;

  plugins.cmp = {
    enable = true;
    settings = {
      snippet.expand = lib.nixvim.mkRaw "function(args) require('luasnip').lsp_expand(args.body) end";
      mapping = {
        "<C-Space>" = lib.nixvim.mkRaw "cmp.mapping.complete()";
        "<CR>" = lib.nixvim.mkRaw "cmp.mapping.confirm({ select = true })";
        "<Tab>" = lib.nixvim.mkRaw "cmp.mapping.select_next_item()";
        "<S-Tab>" = lib.nixvim.mkRaw "cmp.mapping.select_prev_item()";
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
    };
  };

  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        go = [ "goimports" ];
        cs = [ "csharpier" ];
        haskell = [ "fourmolu" ];
      };
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
    };
  };

  autoCmd = [
    {
      event = "BufWritePost";
      pattern = "*.go";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.fn.jobstart({ "go", "mod", "tidy" }, { cwd = vim.fn.getcwd() })
        end
      '';
    }
  ];

  # conform/nvim-lspconfig系フォーマッタのうち、lsp.servers経由で自動インストールされない
  # CLIツール群（stylua/csharpier/fourmoluはフォーマッタでLSPサーバーではない）。
  # goimportsはgotoolsに含まれる。fortuneはalpha-nvimダッシュボードが要求する。
  extraPackages = with pkgs; [
    stylua
    csharpier
    fourmolu
    gotools
    fortune
  ];
}
