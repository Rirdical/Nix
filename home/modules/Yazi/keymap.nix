# keymap.toml equivalent — all keybindings
{ ... }:

{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      # Navigation
      { on = "j"; run = "arrow 1"; desc = "Move down"; }
      { on = "k"; run = "arrow -1"; desc = "Move up"; }
      { on = "h"; run = "leave"; desc = "Go to parent dir"; }
      { on = "l"; run = "enter"; desc = "Enter dir / open file"; }
      { on = "gg"; run = "arrow top"; desc = "Go to top"; }
      { on = "G"; run = "arrow bot"; desc = "Go to bottom"; }

      # Selection
      { on = "<Space>"; run = "toggle"; desc = "Toggle selection"; }
      { on = "v"; run = "toggle_all --state=true"; desc = "Select all"; }
      { on = "V"; run = "toggle_all --state=false"; desc = "Deselect all"; }

      # Operations
      { on = "r"; run = "rename --cursor=before_ext"; desc = "Rename file"; }
      { on = "d"; run = "remove"; desc = "Trash file"; }
      { on = "D"; run = "remove --permanently"; desc = "Delete permanently"; }
      { on = "y"; run = "yank"; desc = "Yank (copy)"; }
      { on = "x"; run = "yank --cut"; desc = "Cut"; }
      { on = "p"; run = "paste"; desc = "Paste"; }
      { on = "P"; run = "paste --force"; desc = "Paste (overwrite)"; }

      # Preview
      { on = "<Tab>"; run = "show_preview"; desc = "Show/hide preview"; }
      { on = "<A-k>"; run = "seek -5"; desc = "Scroll preview up"; }
      { on = "<A-j>"; run = "seek 5"; desc = "Scroll preview down"; }

      # Find & Filter
      { on = "/"; run = "find --smart"; desc = "Find file"; }
      { on = "n"; run = "find_arrow"; desc = "Next find result"; }
      { on = "N"; run = "find_arrow --previous"; desc = "Prev find result"; }
      { on = "f"; run = "filter --smart"; desc = "Filter files"; }

      # Sort
      { on = ",m"; run = "sort mime --reverse=no"; desc = "Sort by mime"; }
      { on = ",M"; run = "sort mime --reverse"; desc = "Sort by mime (rev)"; }
      { on = ",s"; run = "sort size --reverse=no"; desc = "Sort by size"; }
      { on = ",n"; run = "sort natural --reverse=no"; desc = "Sort naturally"; }
      { on = ",N"; run = "sort natural --reverse"; desc = "Sort naturally (rev)"; }
      { on = ",c"; run = "sort created --reverse=no"; desc = "Sort by created"; }
      { on = ",m"; run = "sort modified --reverse=no"; desc = "Sort by modified"; }

      # Tabs
      { on = "t"; run = "tab_create --current"; desc = "New tab"; }
      { on = "<A-1>"; run = "tab_switch 0"; desc = "Tab 1"; }
      { on = "<A-2>"; run = "tab_switch 1"; desc = "Tab 2"; }
      { on = "<A-3>"; run = "tab_switch 2"; desc = "Tab 3"; }
      { on = "<A-4>"; run = "tab_switch 3"; desc = "Tab 4"; }
      { on = "["; run = "tab_switch -1 --relative"; desc = "Prev tab"; }
      { on = "]"; run = "tab_switch 1 --relative"; desc = "Next tab"; }
      { on = "{"; run = "tab_swap -1"; desc = "Swap tab left"; }
      { on = "}"; run = "tab_swap 1"; desc = "Swap tab right"; }

      # Plugins
      { on = "<C-d>"; run = "plugin drag"; desc = "Drag and drop"; }
      { on = "T"; run = "plugin toggle-pane max-preview"; desc = "Maximize preview"; }
      { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Chmod selected"; }
      { on = "M"; run = "plugin mount"; desc = "Mount manager"; }

      # Shell
      { on = "!"; run = "shell --interactive"; desc = "Run shell command"; }
      { on = "$"; run = "shell \"$SHELL\" --block"; desc = "Open shell here"; }

      # Quit
      { on = "q"; run = "quit"; desc = "Quit"; }
      { on = "Q"; run = "quit --no-cwd-file"; desc = "Quit (no cwd save)"; }
    ];

    input.prepend_keymap = [
      { on = "<C-c>"; run = "close"; desc = "Cancel input"; }
      { on = "<Esc>"; run = "close"; desc = "Cancel input"; }
      { on = "<Enter>"; run = "close --submit"; desc = "Submit"; }
    ];

    help.prepend_keymap = [
      { on = "q"; run = "close"; desc = "Close help"; }
      { on = "<Esc>"; run = "close"; desc = "Close help"; }
    ];

    cmp.prepend_keymap = [
      { on = "<C-n>"; run = "arrow 1"; desc = "Next item"; }
      { on = "<C-p>"; run = "arrow -1"; desc = "Prev item"; }
      { on = "<Enter>"; run = "close --submit"; desc = "Select"; }
      { on = "<Esc>"; run = "close"; desc = "Cancel"; }
    ];
  };
}
