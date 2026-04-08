return {
  "iamcco/markdown-preview.nvim",
  dev = require("nixCatsUtils").isNixCats,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = require("nixCatsUtils").isNixCats and nil or "cd app && npm install",
}
