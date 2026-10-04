{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs.kdePackages; [
    # Core File Manager
    dolphin
    kio-admin                  # Allows managing files as root/administrator

    # --- Previews & Thumbnails ---
    kio-extras                 # Core requirement for network shares and basic thumbnails
    ffmpegthumbs               # Video file thumbnails
    kdegraphics-thumbnailers   # PDF, Blender, and standard image thumbnails
    kimageformats              # Support for advanced images (HEIC, XCF)
    qtimageformats             # Support for WebP, TIFF, etc.

    # --- UI & Wayland Integration ---
    qtwayland                  # Native Wayland support 
    qtsvg                      # Fixes missing SVG rendering in the UI
    breeze-icons               # KDE fallback icon theme (prevents blank UI buttons)
    
    # --- Open With Menu Fix ---
    plasma-workspace           # Provides the 'plasma-applications.menu' file
  ];

  # 1. Fix "Open With" Menu
  # Dolphin searches for this specific XDG menu file to populate the list of applications.
  xdg.configFile."menus/applications.menu".source = 
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # 2. Set the Noctalia Theme
  # Tells Qt applications to look at qt6ct / qt5ct for styling overrides
  qt = {
    enable = true;
    platformTheme.name = "qtct"; 
  };

  # Dolphin explicitly reads `kdeglobals` for its color scheme, ignoring pure qt6ct colors.
  xdg.configFile."kdeglobals".text = ''
    [General]
    ColorScheme=noctalia

    [KDE]
    # Standardizes selection behavior outside of Plasma
    SingleClick=false
  '';

  # 3. Force Previews On By Default
  xdg.configFile."dolphinrc".text = ''
    [PreviewSettings]
    Plugins=audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs
  '';
}
