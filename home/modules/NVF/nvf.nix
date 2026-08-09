{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;

    settings.vim = {
      # ═══════════════════════════════════════════════════════════════
      # 0. VENDORED KEYMAPS — Disable NVF defaults to avoid conflicts
      # ═══════════════════════════════════════════════════════════════
      vendoredKeymaps.enable = false;

      # ═══════════════════════════════════════════════════════════════
      # 1. CORE IDENTITY
      # ═══════════════════════════════════════════════════════════════
      viAlias = true;
      vimAlias = true;
      globals = {
        mapleader = " ";
        editorconfig = true;
      };

      # ═══════════════════════════════════════════════════════════════
      # 2. EDITOR OPTIONS
      # ═══════════════════════════════════════════════════════════════
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
        sidescrolloff = 8;
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        hidden = true;
        undofile = true;
        swapfile = false;
        backup = false;
        writebackup = false;
        updatetime = 250;
        timeoutlen = 300;
        splitbelow = true;
        splitright = true;
        clipboard = "unnamedplus";
        mouse = "a";
        completeopt = "menu,menuone,noselect";
        pumheight = 10;
        showmode = false;
        fillchars = "eob: ";
        shada = "!,'100,<50,s10,h";
      };

      # ═══════════════════════════════════════════════════════════════
      # 3. THEME & VISUALS
      # ═══════════════════════════════════════════════════════════════
      theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
        transparent = false;
      };

      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        rainbow-delimiters.enable = true;
      };

      # ═══════════════════════════════════════════════════════════════
      # 4. STATUSLINE & TABLINE
      # ═══════════════════════════════════════════════════════════════
      statusline = {
        lualine = {
          enable = true;
          theme = "tokyonight";
        };
      };

      tabline.nvimBufferline.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 5. FILE MANAGEMENT
      # ═══════════════════════════════════════════════════════════════
      filetree.neo-tree.enable = true;
      mini.files.enable = true;
      utility.oil-nvim.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 6. FUZZY FINDING
      # ═══════════════════════════════════════════════════════════════
      telescope.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 7. TREESITTER
      # ═══════════════════════════════════════════════════════════════
      treesitter = {
        enable = true;
        context.enable = true;
      };

      # ═══════════════════════════════════════════════════════════════
      # 8. LSP & INTELLIGENCE
      # ═══════════════════════════════════════════════════════════════
      lsp = {
        enable = true;
        formatOnSave = false;
        lspkind.enable = true;
        lightbulb.enable = true;
        trouble.enable = true;
        lspSignature.enable = false;
        inlayHints.enable = true;
      };

      # Modern formatting engine
      formatter.conform-nvim.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 9. AUTOCOMPLETE
      # ═══════════════════════════════════════════════════════════════
      autocomplete = {
        blink-cmp = {
          enable = true;
          setupOpts.signature.enabled = true;
        };
        nvim-cmp.enable = false;
      };

      snippets.luasnip.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 10. DIAGNOSTICS
      # ═══════════════════════════════════════════════════════════════
      diagnostics = {
        enable = true;
        config = {
          virtual_text = true;
          underline = true;
          signs = true;
          update_in_insert = false;
          severity_sort = true;
          float = {
            border = "rounded";
            source = "if_many";
          };
        };
      };

      # ═══════════════════════════════════════════════════════════════
      # 11. GIT
      # ═══════════════════════════════════════════════════════════════
      git = {
        enable = true;
        gitsigns.enable = true;
      };

      # ═══════════════════════════════════════════════════════════════
      # 12. KEYBIND DISCOVERY
      # ═══════════════════════════════════════════════════════════════
      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      # ═══════════════════════════════════════════════════════════════
      # 13. MINI.ECOSYSTEM — All confirmed in NVF 26.12 release notes
      # ═══════════════════════════════════════════════════════════════
      mini = {
        ai.enable = true;
        surround.enable = true;
        pairs.enable = true;
        comment.enable = true;
        move.enable = true;
        splitjoin.enable = true;
        align.enable = true;
        operators.enable = true;
        bracketed.enable = true;
        trailspace.enable = true;
        indentscope.enable = true;
        jump.enable = true;
        jump2d.enable = true;
        hipatterns.enable = true;
        sessions.enable = true;
        starter.enable = true;
      };

      # ═══════════════════════════════════════════════════════════════
      # 14. MOTION — flash.nvim (replaces hop + leap)
      # ═══════════════════════════════════════════════════════════════
      utility.motion.flash-nvim.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 15. YANK HISTORY
      # ═══════════════════════════════════════════════════════════════
      utility.yanky-nvim.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 16. UI ENHANCEMENTS
      # ═══════════════════════════════════════════════════════════════
      ui = {
        noice.enable = true;
        borders.enable = true;
        illuminate.enable = true;
        colorizer.enable = true;
      };

      notify.nvim-notify.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 17. NOTES & MARKDOWN
      # ═══════════════════════════════════════════════════════════════
      notes.todo-comments.enable = true;

      languages.markdown.extensions.render-markdown-nvim.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 18. TERMINAL
      # ═══════════════════════════════════════════════════════════════
      terminal.toggleterm = {
        enable = true;
        lazygit.enable = true;
      };

      # ═══════════════════════════════════════════════════════════════
      # 19. LANGUAGES — Keep ONLY what you use
      # ═══════════════════════════════════════════════════════════════
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

      # ═══════════════════════════════════════════════════════════════
      # 20. KEYMAPS
      # ═══════════════════════════════════════════════════════════════
      keymaps = [
        # ── Telescope ──
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
        {
          key = "<leader>fr";
          mode = "n";
          action = "<cmd>Telescope oldfiles<cr>";
          desc = "Recent files";
        }

        # ── File Tree ──
        {
          key = "<leader>e";
          mode = "n";
          action = "<cmd>Neotree toggle<cr>";
          desc = "Toggle neo-tree";
        }
        {
          key = "<leader>E";
          mode = "n";
          action = "<cmd>lua MiniFiles.open()<cr>";
          desc = "Open mini.files";
        }
        {
          key = "<leader>o";
          mode = "n";
          action = "<cmd>Oil<cr>";
          desc = "Open oil.nvim";
        }

        # ── LSP ──
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

        # ── Diagnostics ──
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

        # ── Buffers ──
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

        # ── Git ──
        {
          key = "<leader>gg";
          mode = "n";
          action = "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd='lazygit',direction='float'}):toggle()<cr>";
          desc = "Lazygit";
        }

        # ── Utility ──
        {
          key = "<leader>ut";
          mode = "n";
          action = "<cmd>lua MiniTrailspace.trim()<cr>";
          desc = "Trim trailing whitespace";
        }
      ];
    };
  };
}
