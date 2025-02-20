{ pkgs, ... }:
{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        shellAliases = {
            sl = "colorls";
            ls = "colorls";
            l = "colorls -l";
            la = "colorls -la";
            ip = "ip --color=auto";
            update = "sudo nixos-rebuild switch --flake .#gwhit-nixos";
            homeupdate = "home-manager switch --flake .#gwhittey@gwhit-nixos  ";
        };
        #initExtra = "source .p10k.zsh";
        plugins = [
            {
            name = "zsh-autosuggestions";
            src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-autosuggestions";
                rev = "v0.6.4";
                sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
            };
            }
            {
            name = "fast-syntax-highlighting";
            src = pkgs.fetchFromGitHub {
                owner = "zdharma";
                repo = "fast-syntax-highlighting";
                rev = "v1.55";
                sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
            };
            }
            {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
            {
            name = "powerlevel10k-config";
            src = ./p10k-config;
            file = "p10k.zsh";
            }

        ];
        };
}
