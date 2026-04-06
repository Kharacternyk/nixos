vim.diagnostic.config({
  virtual_text = true,
})

vim.lsp.enable({
  "clangd",
  "ty",
  "nixd",
})

require("conform").setup({
  format_on_save = {},
  formatters_by_ft = {
    c = {
      "clang-format",
    },
    lua = {
      "stylua",
    },
    nix = {
      "nixpkgs_fmt",
    },
    python = {
      "ruff_format",
      "ruff_fix",
      "ruff_organize_imports",
    },
  },
})

require("blink.cmp").setup({
  completion = {
    documentation = {
      auto_show = true,
    },
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      draw = {
        columns = {
          {
            "label",
            "kind",
            gap = 2,
          },
          {
            "source_name",
          },
        },
        components = {
          label = {
            width = {
              max = 48,
            },
          },
        },
        treesitter = {
          "lsp",
        },
      },
      max_height = 11,
      scrolloff = 100,
    },
  },
  keymap = {
    preset = "none",
    ["<C-h>"] = {
      "cancel",
      "fallback",
    },
    ["<C-k>"] = {
      "show_signature",
      "hide_signature",
      "fallback",
    },
    ["<C-l>"] = {
      "show",
      "select_and_accept",
      "fallback",
    },
    ["<C-n>"] = {
      "scroll_documentation_down",
    },
    ["<C-p>"] = {
      "scroll_documentation_up",
    },
    ["<Tab>"] = {
      "select_next",
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = {
      "select_prev",
      "snippet_backward",
      "fallback",
    },
  },
  signature = {
    enabled = true,
  },
})
