# dolphin.nix
{ pkgs, ... }: {

  # 1. Install Dolphin, thumbnail plugins, and KDE service utilities
  home.packages = with pkgs; [
    kdePackages.dolphin
    kdePackages.kio-extras
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs
    kdePackages.qtimageformats
    kdePackages.kimageformats
    kdePackages.kservice           # Provides kbuildsycoca6 binary
    kdePackages.breeze-icons       # Fixes missing UI icons in standalone compositors
    shared-mime-info
  ];

  # 2. Set environment variables required for Qt6/KDE under Niri
  home.sessionVariables = {
    # Allows Qt6 apps to discover installed image format plugins (WebP, HEIF, etc.)
    QT_PLUGIN_PATH = "$HOME/.nix-profile/lib/qt-6/plugins:/run/current-system/sw/lib/qt-6/plugins";
  };

  # 3. Create the plasma-applications menu entry for "Open With" functionality
  home.file.".config/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # 4. Safely declare Dolphin preview options via HM's structured INI generator
  # Using target ensures HM merges or manages dolphinrc cleanly
  xdg.configFile."dolphinrc".text = ''
    [PreviewSettings]
    MaximumSize=0
    Plugins=appimagethumbnail,audiothumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,ffmpegthumbs,fontthumbnail,gsthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,mrgthumbnail,opendocumentthumbnail,pdfthumbnail,psdthumbnail,rawthumbnail,svgthumbnail,textthumbnail,windowsimagethumbnail,windowsexecutablethumbnail
  '';
}
