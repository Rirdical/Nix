# nvf.nix
{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;
    
    settings.vim = {
      # 🧩 Aliases & Basic Settings
      viAlias = true;          # Enable `vi` command alias for nvim
      vimAlias = true;         # Enable `vim` command alias for nvim
      opts.expandtab = true;   # Use spaces instead of tabs
      
      # 🔍 LSP & Completion (Core IDE Features)
      lsp = {
        enable = true;         # Enable Language Server Protocol support
        formatOnSave = true;   # Format code on save
        trouble.enable = true; # Better diagnostics list
      };
      
      # 🌳 Treesitter (Better Syntax Highlighting & Code Navigation)
      treesitter = {
        enable = true;
        context.enable = true; # Show current context at top of window
      };
      
      # 📝 Language Support (Enable languages you use)
      languages = {
        enableFormat = true;        # Enable code formatting
        enableTreesitter = true;    # Enable Treesitter parsers
        enableExtraDiagnostics = true; # Additional linters
        
        # Enable specific languages (examples)
        nix.enable = true;          # Nix language support
        markdown.enable = true;     # Markdown support
        python.enable = true;       # Python support
        # rust.enable = true;       # Rust support
        # typescript.enable = true; # TypeScript/JavaScript support
        # go.enable = true;         # Go support
      };
      
      # 🎨 Visual Enhancements
      visuals = {
        nvim-web-devicons.enable = true; # File icons
        indent-blankline.enable = true;  # Indentation guides
        cinnamon-nvim.enable = true;     # Smooth scrolling
      };
      
      # 📊 Statusline & Tabline
      statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin"; # Match your theme
        };
      };
      
      tabline = {
        nvimBufferline.enable = true; # Buffer/tab line
      };
      
      # 🎯 Theme (Catppuccin is popular and well-supported)
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha"; # latte, frappe, macchiato, mocha
      };
      
      # 🔧 Utility Plugins
      telescope.enable = true;        # Fuzzy finder
      binds.whichKey.enable = true;         # Keybinding hints
      comments.comment-nvim.enable = true;     # Easy commenting
      autopairs.nvim-autopairs.enable = true;   # Auto close brackets/quotes
      
      # 🗂️ File Explorer
      filetree = {
        neo-tree.enable = true;
      };
      
      # ⌨️ Keybindings (Example)
      keymaps = [
        # Example: Leader key is space by default
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<CR>";
          desc = "Find Files";
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<CR>";
          desc = "Live Grep";
        }
      ];
      
      # 🖥️ Terminal Integration
      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true; # Git integration
        };
      };
      
      # 🔔 Notifications
      notify = {
        nvim-notify.enable = true;
      };
      
      # 📝 Git Integration
      git = {
        enable = true;
        gitsigns.enable = true; # Git signs in gutter
      };
    };
  };
}
