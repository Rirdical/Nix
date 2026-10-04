# nvf.nix — universal, general-purpose Neovim config for NVF
# https://github.com/NotAShelf/nvf
#
# Works as a plain nvf module (see flake.nix) or under Home Manager / NixOS:
#   programs.nvf.settings = import ./nvf.nix { inherit lib pkgs; };
#
# Option names were checked against nvf's current `main` sample configuration.
# nvf evolves quickly: if an option errors after an update, check the release
# notes (https://notashelf.github.io/nvf/release-notes.html) for renames.
{
  lib,
  pkgs,
  ...
}: {
  vim = {
    viAlias = true;
    vimAlias = true;

    # ────────────────────────────────────────────────────────────────────
    # Core editor behaviour
    # ────────────────────────────────────────────────────────────────────
    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    lineNumberMode = "relNumber"; # relative numbers + absolute on current line
    searchCase = "smart"; # case-insensitive unless the query has capitals
    undoFile.enable = true; # persistent undo across sessions
    preventJunkFiles = true; # no swap/backup clutter

    clipboard = {
      enable = true;
      registers = "unnamedplus"; # yank/paste use the system clipboard
      # Pick the provider that matches your session if auto-detection fails:
      providers.wl-copy.enable = true; # Wayland
      # providers.xclip.enable = true;   # X11
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      scrolloff = 8;
      sidescrolloff = 8;
      signcolumn = "yes"; # no layout jumping when diagnostics appear
      wrap = false;
      confirm = true; # ask instead of failing on unsaved buffers
      inccommand = "split"; # live preview for :s
      showmode = false; # lualine already shows the mode
      list = true;
      listchars = "tab:» ,trail:·,nbsp:␣";
    };

    # Tools that telescope / grug-far / etc. shell out to
    extraPackages = with pkgs; [
      ripgrep
      fd
    ];

    # ────────────────────────────────────────────────────────────────────
    # Keymaps (kept clear of nvf's built-in <leader> groups)
    # ────────────────────────────────────────────────────────────────────
    keymaps = [
      {
        key = "<Esc>";
        mode = "n";
        action = "<cmd>nohlsearch<CR>";
        silent = true;
        desc = "Clear search highlight";
      }
      {
        key = "<C-s>";
        mode = ["n" "i" "v"];
        action = "<cmd>w<CR><Esc>";
        silent = true;
        desc = "Save file";
      }
      {
        key = "<leader>e";
        mode = "n";
        action = "<cmd>Neotree toggle<CR>";
        silent = true;
        desc = "Toggle file tree";
      }
      {
        key = "<S-h>";
        mode = "n";
        action = "<cmd>bprevious<CR>";
        silent = true;
        desc = "Previous buffer";
      }
      {
        key = "<S-l>";
        mode = "n";
        action = "<cmd>bnext<CR>";
        silent = true;
        desc = "Next buffer";
      }
      {
        key = "<leader>bd";
        mode = "n";
        action = "<cmd>bdelete<CR>";
        silent = true;
        desc = "Delete buffer";
      }
      # Keep the selection when indenting
      {
        key = "<";
        mode = "v";
        action = "<gv";
        desc = "Indent left (keep selection)";
      }
      {
        key = ">";
        mode = "v";
        action = ">gv";
        desc = "Indent right (keep selection)";
      }
      # Move selected lines up/down
      {
        key = "J";
        mode = "v";
        action = ":m '>+1<CR>gv=gv";
        silent = true;
        desc = "Move selection down";
      }
      {
        key = "K";
        mode = "v";
        action = ":m '<-2<CR>gv=gv";
        silent = true;
        desc = "Move selection up";
      }
      # Keep the cursor centered while searching / paging
      {
        key = "n";
        mode = "n";
        action = "nzzzv";
        desc = "Next match (centered)";
      }
      {
        key = "N";
        mode = "n";
        action = "Nzzzv";
        desc = "Previous match (centered)";
      }
      {
        key = "<C-d>";
        mode = "n";
        action = "<C-d>zz";
        desc = "Half page down (centered)";
      }
      {
        key = "<C-u>";
        mode = "n";
        action = "<C-u>zz";
        desc = "Half page up (centered)";
      }
      # Paste over a selection without clobbering the unnamed register
      {
        key = "p";
        mode = "x";
        action = ''"_dP'';
        desc = "Paste without yanking the replaced text";
      }
    ];

    autocmds = [
      {
        event = ["TextYankPost"];
        desc = "Highlight yanked text";
        callback = lib.generators.mkLuaInline ''
          function() vim.hl.on_yank() end
        '';
      }
      {
        event = ["BufReadPost"];
        desc = "Restore last cursor position";
        callback = lib.generators.mkLuaInline ''
          function(args)
            local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
            local lines = vim.api.nvim_buf_line_count(args.buf)
            if mark[1] > 0 and mark[1] <= lines then
              pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
          end
        '';
      }
    ];

    # ────────────────────────────────────────────────────────────────────
    # LSP, diagnostics, debugging
    # ────────────────────────────────────────────────────────────────────
    lsp = {
      # Must be on for the language modules below to hook into the LSP API
      enable = true;
      formatOnSave = true;
      lightbulb.enable = true;
      trouble.enable = true; # nicer diagnostics / references list
      presets.nixd.enable = true;
      # lspSignature stays off: blink-cmp ships its own signature help
    };

    diagnostics = {
      enable = true;
      config = {
        virtual_text = true;
        underline = true;
        update_in_insert = false;
        severity_sort = true;
        float = {
          border = "rounded";
          source = "if_many";
        };
      };
    };

    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };

    # ────────────────────────────────────────────────────────────────────
    # Languages (LSP + formatter + treesitter + linters per language)
    # ────────────────────────────────────────────────────────────────────
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      enableDAP = true;

      # Everyday set
      nix.enable = true;
      markdown.enable = true;
      bash.enable = true;
      lua.enable = true;
      python.enable = true;
      go.enable = true;
      clang.enable = true; # C / C++
      rust = {
        enable = true;
        extensions.crates-nvim.enable = true; # Cargo.toml version hints
      };

      # Web + config formats
      typescript.enable = true; # TS / JS
      html.enable = true;
      css.enable = true;
      json.enable = true;
      toml.enable = true;
      docker.enable = true;
      env.enable = true;

      # ── Optional: uncomment what you need (each one pulls in its tools) ──
      # sql.enable = true;
      # cmake.enable = true;
      # java.enable = true;
      # kotlin.enable = true;
      # zig.enable = true;
      # typst.enable = true;
      # tex.enable = true;
      # xml.enable = true;
      # scss.enable = true;
      # tsx.enable = true;
      # vue.enable = true;
      # svelte.enable = true;
      # fish.enable = true;
      # zsh.enable = true;
      # make.enable = true;
      # just.enable = true;
      # haskell.enable = true;
      # ocaml.enable = true;
      # ruby.enable = true;
      # csharp.enable = true;
      # yaml.enable = true; # check the nvf manual for your version
    };

    # ────────────────────────────────────────────────────────────────────
    # Completion & snippets
    # ────────────────────────────────────────────────────────────────────
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts.signature.enabled = true;
    };
    # Prefer nvim-cmp? Disable blink-cmp above and use:
    # autocomplete.nvim-cmp.enable = true;

    snippets.luasnip.enable = true;
    autopairs.nvim-autopairs.enable = true;

    # ────────────────────────────────────────────────────────────────────
    # Look & feel
    # ────────────────────────────────────────────────────────────────────
    theme = {
      enable = true;
      name = "catppuccin"; # also: tokyonight, gruvbox, onedark, dracula, rose-pine, ...
      style = "mocha";
      transparent = true;
    };

    statusline.lualine = {
      enable = true;
      integrations.breadcrumbs.nvim-navic.enable = true;
    };

    tabline.nvimBufferline.enable = true;

    visuals = {
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      nvim-scrollbar.enable = true;
      fidget-nvim.enable = true; # LSP progress
      highlight-undo.enable = true;
      indent-blankline.enable = true;
    };

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true; # inline color previews (#ff00ff)
      illuminate.enable = true; # highlight other uses of the word under cursor
      smartcolumn.enable = true;
      fastaction.enable = true;
    };

    notify.nvim-notify.enable = true;
    treesitter.context.enable = true; # sticky function/class header

    dashboard.alpha.enable = true;

    # ────────────────────────────────────────────────────────────────────
    # Navigation & workflow
    # ────────────────────────────────────────────────────────────────────
    filetree.neo-tree.enable = true;
    telescope.enable = true;
    projects.project-nvim.enable = true;

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    git = {
      enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = false; # noisy debug message on some setups
      };
    };

    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
    };

    comments.comment-nvim.enable = true;
    notes.todo-comments.enable = true;

    utility = {
      diffview-nvim.enable = true;
      surround.enable = true;
      undotree.enable = true;
      smart-splits.enable = true; # <C-h/j/k/l> works across splits and tmux
      grug-far-nvim.enable = true; # project-wide search & replace
      multicursors.enable = true;
      motion.leap.enable = true;
    };

    # ── Optional extras ──
    # spellcheck = {
    #   enable = true;
    #   languages = ["en"];
    #   programmingWordlist.enable = true;
    # };
    # session.nvim-session-manager.enable = true;
    # assistant.copilot.enable = true;
    # minimap.minimap-vim.enable = true;
  };
}
