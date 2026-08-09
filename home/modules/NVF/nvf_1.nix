{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;

    settings.vim = {
      # ── Aliases ──
      viAlias = true;
      vimAlias = true;

      # ── Leader ──
      globals.mapleader = " ";

      # ── Core Editor Options ──
      options = {
        number = true;
        relativenumber = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        autoindent = true;
        smartindent = true;
        termguicolors = true;
        cursorline = true;
        signcolumn = "yes";
        laststatus = 3;
        wrap = false;
        scrolloff = 10;
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        hidden = true;
        undofile = true;
        swapfile = false;
        updatetime = 250;
        timeoutlen = 300;
        splitbelow = true;
        splitright = true;
        clipboard = "unnamedplus";
        mouse = "a";
      };

      # ── Theme ──
      theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
        transparent = true;
      };

      # ── Statusline ──
      statusline = {
        lualine = {
          enable = true;
          theme = "tokyonight";
        };
      };

      # ── Tabline (Buffer Tabs) ──
      tabline.nvimBufferline.enable = true;

      # ── File Tree ──
      filetree.neo-tree.enable = true;

      # ── Fuzzy Finder ──
      telescope.enable = true;

      # ── Syntax & Parsing ──
      treesitter = {
        enable = true;
        context.enable = true;
      };

      # ── LSP ──
      lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = true;
        lightbulb.enable = true;
        trouble.enable = true;
        lspSignature.enable = false; # blink-cmp handles this
      };

      # ── Autocomplete ──
      autocomplete = {
        blink-cmp = {
          enable = true;
          setupOpts.signature.enabled = true;
        };
        nvim-cmp.enable = false;
      };

      snippets.luasnip.enable = true;

      # ── Diagnostics ──
      diagnostics = {
        enable = true;
        config = {
          virtual_text = true;
          underline = true;
          signs = true;
          update_in_insert = false;
        };
      };

      # ── Git ──
      git = {
        enable = true;
        gitsigns.enable = true;
      };

      # ── Keybind Discovery ──
      binds.whichKey.enable = true;

      # ── Auto-pairs ──
      autopairs.nvim-autopairs.enable = true;

      # ── Comments ──
      comments.comment-nvim.enable = true;

      # ── Better UI ──
      ui = {
        noice.enable = true;
        borders.enable = true;
        illuminate.enable = true;
      };

      # ── Notifications ──
      notify.nvim-notify.enable = true;

      # ── Notes / Todos ──
      notes.todo-comments.enable = true;

      # ── Terminal ──
      terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };

      # ── Motion ──
      utility.motion = {
        hop.enable = true;
        leap.enable = true;
      };

      # ── Visuals ──
      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      # ── Languages ──
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        lua.enable = true;
        bash.enable = true;
        markdown.enable = true;
        json.enable = true;
        yaml.enable = true;
        html.enable = true;
        css.enable = true;
        typescript.enable = true;
        python.enable = true;
        rust.enable = true;
        go.enable = true;
      };

      # ── Keymaps ──
      # NOTE: NVF keymaps use TOP-LEVEL attrs, NOT nested under `options`.
      # Valid attrs per keymap: key, mode, action, desc, silent, nowait, expr, unique, remap, lua, buffer
      keymaps = [
        # Telescope
        {
          key = "<leader>ff";
          mode = "n";
          action = "<cmd>Telescope find_files<cr>";
          desc = "Find files";
        }
        {
          key = "<leader>fg";
          mode = "n";
          action = "<cmd>Telescope live_grep<cr>";
          desc = "Live grep";
        }
        {
          key = "<leader>fb";
          mode = "n";
          action = "<cmd>Telescope buffers<cr>";
          desc = "Buffers";
        }
        {
          key = "<leader>fh";
          mode = "n";
          action = "<cmd>Telescope help_tags<cr>";
          desc = "Help tags";
        }

        # File tree
        {
          key = "<leader>e";
          mode = "n";
          action = "<cmd>Neotree toggle<cr>";
          desc = "Toggle file explorer";
        }

        # LSP
        {
          key = "gd";
          mode = "n";
          action = "<cmd>lua vim.lsp.buf.definition()<cr>";
          desc = "Go to definition";
        }
        {
          key = "gr";
          mode = "n";
          action = "<cmd>lua vim.lsp.buf.references()<cr>";
          desc = "Find references";
        }
        {
          key = "K";
          mode = "n";
          action = "<cmd>lua vim.lsp.buf.hover()<cr>";
          desc = "Hover docs";
        }
        {
          key = "<leader>ca";
          mode = "n";
          action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
          desc = "Code action";
        }
        {
          key = "<leader>rn";
          mode = "n";
          action = "<cmd>lua vim.lsp.buf.rename()<cr>";
          desc = "Rename symbol";
        }

        # Diagnostics
        {
          key = "<leader>xx";
          mode = "n";
          action = "<cmd>Trouble diagnostics toggle<cr>";
          desc = "Diagnostics (Trouble)";
        }
        {
          key = "]d";
          mode = "n";
          action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
          desc = "Next diagnostic";
        }
        {
          key = "[d";
          mode = "n";
          action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
          desc = "Prev diagnostic";
        }

        # Buffers
        {
          key = "<S-h>";
          mode = "n";
          action = "<cmd>bprevious<cr>";
          desc = "Prev buffer";
        }
        {
          key = "<S-l>";
          mode = "n";
          action = "<cmd>bnext<cr>";
          desc = "Next buffer";
        }
        {
          key = "<leader>bd";
          mode = "n";
          action = "<cmd>bdelete<cr>";
          desc = "Delete buffer";
        }

        # Git (lazygit via toggleterm)
        {
          key = "<leader>gg";
          mode = "n";
          action = "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd='lazygit',direction='float'}):toggle()<cr>";
          desc = "Lazygit";
        }
      ];
    };
  };
}
