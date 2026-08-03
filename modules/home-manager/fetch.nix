{ pkgs, inputs, ... }: 

{
  imports = [ inputs.areofyl-fetch.homeManagerModules.default ];
  
  programs.fetch = {
    enable = true;
    labelColor = "red";
    # info = [    ];
    # speed = 2.0;
    # spin = "y";
    # size = 2.0;
  };
  
}
