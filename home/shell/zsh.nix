{ config, lib, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      l = "ls -l";
      ll = "ls -la";
      rg = "source ranger";
    };
    history = {
      path = "${config.home.homeDirectory}/.zshistory";
      save = 10000;
      share = true;
    };
    historySubstringSearch = {
      enable = true;
    };

    initExtra = ''
      # search history based on what's typed in the prompt
      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "^[OA" history-beginning-search-backward-end
      bindkey "^[OB" history-beginning-search-forward-end

      # case insensitive tab completion
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' list-colors
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' verbose true
      _comp_options+=(globdots)
    '';

  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

	programs.skim = {
		enable = true;
		enableZshIntegration = true;
		defaultCommand = "rg --files --hidden";
		changeDirWidgetOptions = [
			"--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
			"--exact"
		];
	};

}
