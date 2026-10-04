  { pkgs, ... }:
{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      clock = "%c";
      bigclock = true;
      allow_empty_password = true;
      animation_timeout_sec = "0";
      asterisk = "0x2022";
      bg = "0x20000000";
      bigclock_seconds = true;
      blank_box = false;
      border_fg = "0x00FFFFFF";
      box_title = "GO FUCK YOURSELF";
      clear_password = false;
      cmatrix_fg = "0x001A1B26";
      cmatrix_head_col = "0x01FFFFFF";
      cmatrix_min_codepoint = "0x21";
      cmatrix_max_codepoint = "0x7B";
      colormix_col1 = "0x00BB9AF7";
      colormix_col2 = "0x0023283B";
      colormix_col3 = "0x20BB9AF7";
      error_bg = "0x20000000";
      error_fg = "0x01F7768E";
      fg = "0x41C0CAF5";
      full_color = true;
    };
  };
}

