# plugins + init.lua
{ pkgs, lib, ... }:

{
  programs.yazi = {
    plugins = {
      # Simple plugins (just the package)
      drag = pkgs.yaziPlugins.drag;
      full-border = pkgs.yaziPlugins.full-border;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
      chmod = pkgs.yaziPlugins.chmod;
      mount = pkgs.yaziPlugins.mount;
      smart-enter = pkgs.yaziPlugins.smart-enter;

      # Plugin with setup() arguments
      yatline = {
        package = pkgs.yaziPlugins.yatline;
        setup = true;
        settings = {
          tab_width = 20;
          theme = lib.mkLuaInline ''require("yatline-catppuccin"):setup("mocha")'';
        };
      };

      yatline-catppuccin = pkgs.yaziPlugins.yatline-catppuccin;
    };

    initLua = ''
      require("full-border"):setup()
      require("smart-enter"):setup { open_multi = true }
    '';
  };
}
