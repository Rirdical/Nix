{inputs, ...}:
let
  noctalia = import ./noctalia-theme.nix;
in
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;

    settings.vim = {
      # ═══════════════════════════════════════════════════════════════
      # 0. VENDORED KEYMAPS — Disable NVF defaults keymaps to avoid conflicts
      # ═══════════════════════════════════════════════════════════════
      vendoredKeymaps.enable = false;

      # ═══════════════════════════════════════════════════════════════
      # 1. CORE IDENTITY
      # ═══════════════════════════════════════════════════════════════
      viAlias = true;         # alias in shell for vi
      vimAlias = true;        # alias in shell for vim
      globals = {
        mapleader = " ";      # set <leader> key
        editorconfig = true;  # Makes Neovim respect .editorconfig files in project roots
      };

      # ═══════════════════════════════════════════════════════════════
      # 2. EDITOR OPTIONS
      # ═══════════════════════════════════════════════════════════════
      options = {
        number = true;          # Shows absolute line numbers in the left gutter.
        relativenumber = true;  # All lines except the current one show relative distance
        tabstop = 2;            # visual width of a Tab character.
        shiftwidth = 2;         # how many spaces
        expandtab = true;       # Pressing <Tab> inserts spaces, not a real \t tab character.
        autoindent = true;      # new line copies current indentation.
        smartindent = true;     # new line copies current indentation.
        termguicolors = true;   # Enables 24-bit true color. Required for themes to display millions of colors instead of 256.
        cursorline = true;      # Highlights the entire horizontal line where your cursor sits.
        signcolumn = "yes";     # The gutter left of line numbers is always visible, even when empty.
        laststatus = 3;         # 3 = one global statusline at the bottom for the whole editor. 2 = one per split window.
        wrap = false;           # Disables line wrapping. Long lines extend off-screen; you scroll horizontally.
        scrolloff = 10;         # always keep 10 lines visible above/below cursor.
        sidescrolloff = 8;      # keep 8 columns left/right when wrap is off.
        ignorecase = true;      # /foo matches Foo and FOO
        smartcase = true;       # if query has uppercase (/Foo), it becomes case-sensitive.
        incsearch = true;       # Incremental search — jumps to and highlights matches as you type /pattern
        hidden = true;          # Switch buffers without saving first. The buffer stays loaded in background.
        undofile = true;        # Undo history is saved to disk (~/.local/share/nvim/undo/). Close Neovim, reopen later, still undo.
        swapfile = false;       # Disables .swp
        backup = false;         # disables baskup
        writebackup = false;    # disables wwritebackup files
        updatetime = 250;       # Milliseconds before CursorHold event triggers. Affects LSP hover, git blame, and plugin responsiveness.
        timeoutlen = 300;       # Milliseconds Neovim waits for the next key in a sequence (e.g. <leader>f...). After this, the partial keymap is discarded.
        splitbelow = true;      # :split opens below,
        splitright = true;      # :vsplit opens right
        clipboard = {
          registers = "unnamedplus";
          providers = {
            wl-copy.enable = true;
          };
        };
        mouse = "a";            # Mouse works in all modes: click to place cursor, drag to select, scroll, resize splits.
        completeopt = "menu,menuone,noselect";  # Completion menu behavior: menu = show popup, menuone = show even for 1 match, noselect = don't auto-insert first item.
        pumheight = 10;         # Popup menu height limit. Completion list shows max 10 items, then scrolls.
        showmode = false;       # Hides the -- INSERT -- / -- VISUAL -- text at the bottom.
        fillchars = "eob: ";    # Changes the ~ characters on empty lines after file end to spaces (invisible).
        shada = "!,'100,<50,s10,h"; # Shared data (shada) config: ! = save global marks, '100 = save 100 file marks, <50 = save 50 lines of registers, s10 = max 10KB per item, h = disable hlsearch on startup.
      };

      # ═══════════════════════════════════════════════════════════════
      # 3. THEME & VISUALS
      # ═══════════════════════════════════════════════════════════════
      theme = {
        enable = true;
        name = "base16";
        base16-colors = noctalia;
        transparent = true;
      };

      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        rainbow-delimiters.enable = true;
      };
      luaConfigRC.noctalia-telescope = ''
        local hi = function(group, opts)
          vim.api.nvim_set_hl(0, group, opts)
        end

        -- Telescope custom highlights (from matugen.lua)
        hi('TelescopeNormal',         { fg = '#f3edf7', bg = '#070722' })
        hi('TelescopeBorder',         { fg = '#4e4ec2', bg = '#070722' })
        hi('TelescopePromptNormal',   { fg = '#f3edf7', bg = '#070722' })
        hi('TelescopePromptBorder',   { fg = '#4e4ec2', bg = '#070722' })
        hi('TelescopePromptPrefix',   { fg = '#fff59b', bg = '#070722' })
        hi('TelescopePromptCounter',  { fg = '#7c80b4', bg = '#070722' })
        hi('TelescopePromptTitle',    { fg = '#070722', bg = '#fff59b' })
        hi('TelescopePreviewTitle',   { fg = '#070722', bg = '#a9aefe' })
        hi('TelescopeResultsTitle',   { fg = '#070722', bg = '#9bfece' })
        hi('TelescopeSelection',      { fg = '#f3edf7', bg = '#17173c' })
        hi('TelescopeSelectionCaret', { fg = '#fff59b', bg = '#17173c' })
        hi('TelescopeMatching',       { fg = '#fff59b', bold = true })

        -- SIGUSR1 handler for matugen dynamic theme updates
        local signal = vim.uv.new_signal()
        if signal then
          signal:start('sigusr1', vim.schedule_wrap(function()
            -- Reload base16 colorscheme with Noctalia palette
            require('base16-colorscheme').setup({
              base00 = '#070722',
              base01 = '#11112d',
              base02 = '#17173c',
              base03 = '#4e4ec2',
              base04 = '#7c80b4',
              base05 = '#f3edf7',
              base06 = '#f3edf7',
              base07 = '#f3edf7',
              base08 = '#fd4663',
              base09 = '#9bfece',
              base0A = '#a9aefe',
              base0B = '#fff59b',
              base0C = '#81fec1',
              base0D = '#fff280',
              base0E = '#8188fe',
              base0F = '#910017',
            })

            -- Re-apply telescope highlights after reload
            hi('TelescopeNormal',         { fg = '#f3edf7', bg = '#070722' })
            hi('TelescopeBorder',         { fg = '#4e4ec2', bg = '#070722' })
            hi('TelescopePromptNormal',   { fg = '#f3edf7', bg = '#070722' })
            hi('TelescopePromptBorder',   { fg = '#4e4ec2', bg = '#070722' })
            hi('TelescopePromptPrefix',   { fg = '#fff59b', bg = '#070722' })
            hi('TelescopePromptCounter',  { fg = '#7c80b4', bg = '#070722' })
            hi('TelescopePromptTitle',    { fg = '#070722', bg = '#fff59b' })
            hi('TelescopePreviewTitle',   { fg = '#070722', bg = '#a9aefe' })
            hi('TelescopeResultsTitle',   { fg = '#070722', bg = '#9bfece' })
            hi('TelescopeSelection',      { fg = '#f3edf7', bg = '#17173c' })
            hi('TelescopeSelectionCaret', { fg = '#fff59b', bg = '#17173c' })
            hi('TelescopeMatching',       { fg = '#fff59b', bold = true })
          end))
        end
      '';

      # ═══════════════════════════════════════════════════════════════
      # 4. STATUSLINE & TABLINE
      # ═══════════════════════════════════════════════════════════════
      statusline = {
        lualine = {
          enable = true;
          theme = "base16";
        };
      };

      tabline.nvimBufferline.enable = true;

      # ═══════════════════════════════════════════════════════════════
      # 5. FILE MANAGEMENT
      # ═══════════════════════════════════════════════════════════════
      filetree.neo-tree.enable = true; # enable neotree sidebar file tree
      mini.files.enable = true;        # Column-based file browser. <leader>E opens it. Great for bulk renames
      utility.oil-nvim.enable = true;  # Edit the filesystem like a text buffer. <leader>o opens the current directory. You dd a file to delete, yy to copy, edit a name to rename.

      # ═══════════════════════════════════════════════════════════════
      # 6. FUZZY FINDING
      # ═══════════════════════════════════════════════════════════════
      telescope.enable = true;         # The fuzzy finder. Search files, grep text, list buffers, help tags.

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
          friendly-snippets.enable = true;
          mappings = {
            complete = null;
            close = null;
            scrollDocsUp = null;
            scrollDocsDown = null;
            confirm = null;
            next = null;
            previous = null;
          };
          setupOpts = {
            signature.enabled = true;
            keymap = {
              "<Tab>" = ["select_next" "snippet_forward" "fallback"];
              "<S-Tab>" = ["select_prev" "snippet_backward" "fallback"];
              "<CR>" = ["accept" "fallback"];
              "<C-y>" = ["select_and_accept" "fallback"];
              "<C-e>" = ["hide" "fallback"];
              "<C-space>" = ["show" "fallback"];
              "<C-d>" = ["scroll_documentation_up" "fallback"];
              "<C-f>" = ["scroll_documentation_down" "fallback"];
            };
          };
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
