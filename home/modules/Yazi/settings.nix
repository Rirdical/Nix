# yazi.toml equivalent — general behavior, preview, sorting, openers
{ pkgs, ... }:

{
  programs.yazi.settings = {
    mgr = {
      show_hidden = true;
      sort_by = "natural";
      sort_dir_first = true;
      sort_reverse = false;
      linemode = "size";
      show_symlink = true;
    };

    preview = {
      tab_size = 2;
      max_width = 1200;
      max_height = 900;
      image_filter = "lanczos3";
      image_quality = 90;
      wrap = "no";
    };

    opener = {
      open = [
        {
          run = ''xdg-open "$1"'';
          desc = "Open with default app";
          for = "linux";
          block = false;
        }
      ];
      edit = [
        {
          run = ''$EDITOR "$1"'';
          desc = "Edit in $EDITOR";
          block = true;
        }
      ];
      reveal = [
        {
          run = ''xdg-open "$(dirname "$1")"'';
          desc = "Reveal in file manager";
          for = "linux";
        }
      ];
    };

    open = {
      rules = [
        { mime = "text/*"; use = "edit"; }
        { mime = "image/*"; use = "open"; }
        { mime = "video/*"; use = "open"; }
        { mime = "audio/*"; use = "open"; }
        { mime = "application/pdf"; use = "open"; }
        { mime = "application/zip"; use = "open"; }
        { mime = "*"; use = "open"; }
      ];
      append_rules = [
        { name = "*/"; use = "edit"; }
      ];
    };

    input.cursor_blink = false;

    select = {
      open_offset = [ 0 1 2 3 4 5 6 7 ];
      open_origin = "hovered";
    };

    trash.use_trash = true;
    log.enabled = false;
  };
}
