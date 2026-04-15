vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cachePriming = {
        enable = false,
      },
      cargo = {
        allTargets = false,
        extraEnv = {
          CARGO_NET_OFFLINE = "true",
        },
        buildScripts = {
          enable = false,
        },
      },
      check = {
        allTargets = false,
        extraEnv = {
          CARGO_NET_OFFLINE = "true",
        },
      },
      procMacro = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable({
  "clangd",
  "lua_ls",
  "nixd",
  "rust_analyzer",
  "ty",
})

biome = {
  "biome",
  "biome-organize-imports",
}

require("conform").setup({
  format_on_save = {},
  formatters = {
    biome = {
      append_args = {
        "--expand",
        "always",
      },
    },
  },
  formatters_by_ft = {
    c = {
      "clang-format",
    },
    css = biome,
    javascript = biome,
    javascriptreact = biome,
    json = biome,
    jsonc = biome,
    html = biome,
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
    rust = {
      "rustfmt",
    },
    typescript = biome,
    typescriptreact = biome,
  },
})

require("diagflow").setup()

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
          },
          {
            "kind",
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
