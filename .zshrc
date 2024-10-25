# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=( 
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias ls='\sl -F -a -l'
alias sl='\ls'

# Fonction pour afficher l'écran d'accueil Mécanicus avec des couleurs et des barres de progression dynamiques
function mecanicus_greeting() {
  clear

  # Récupérer l'utilisation du disque (%)
  disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
  
  # Récupérer l'utilisation du CPU (%)
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

  # Fonction pour générer une barre de progression
  function progress_bar() {
    local usage=$1
    local total=50  # longueur de la barre
    local filled=$(($usage * $total / 100))  # portion remplie
    local empty=$(($total - $filled))  # portion vide

    # Générer les blocs remplis et vides sans retour à la ligne
    local bar_filled=$(repeat $filled echo -n '█')
    local bar_empty=$(repeat $empty echo -n '▒')

    # Afficher la barre avec couleurs sur la même ligne
    print -P "%F{yellow}${bar_filled}%F{cyan}${bar_empty} %F{white}${usage}%%"
  }

  # Afficher l'écran d'accueil
  print -P "%F{green}╔══════════════════════════════════════════════════════════════════════════╗%f"
  print -P "%F{green}║%f  %F{cyan}Adeptus Mechanicus - Ordinateur Cogitateur Sacré%f                        %F{green}║%f"
  print -P "%F{green}║%f  Connexion au %F{yellow}Noosphere%f…                                                 %F{green}║%f"
  print -P "%F{green}╠══════════════════════════════════════════════════════════════════════════╣%f"
  print -P "%F{green}║%f > %F{cyan}Invoquer Code Machine%f...                                               %F{green}║%f"
  print -P "%F{green}║%f > %F{cyan}Vérification des rites de machine%f...                                   %F{green}║%f"
  print -P "%F{green}║%f > %F{cyan}Sanctification de l'esprit-machine en cours%f...                         %F{green}║%f"
  print -P "%F{green}╟──────────────────────────────────────────────────────────────────────────╢%f"
  print -P "%F{green}║%f [Date] : %F{yellow}$(date '+%A %d %B %Y')%f                                          %F{green}║%f"
  print -P "%F{green}║%f [Heure] : %F{yellow}$(date '+%H:%M:%S')%f                                                       %F{green}║%f"
  print -P "%F{green}║%f [Utilisateur] : %F{yellow}$(whoami)%f                                                    %F{green}║%f"
  print -P "%F{green}║%f [Système] : %F{yellow}$(uname -n)%f                                            %F{green}║%f"
  print -P "%F{green}╟──────────────────────────────────────────────────────────────────────────╢%f"
  print -P "%F{green}║%f %F{red}Disque :%f  $(progress_bar $disk_usage)%%          %F{green}║%f"
  print -P "%F{green}║%f %F{cyan}CPU :%f     $(progress_bar ${cpu_usage%.*})%%           %F{green}║%f"
  print -P "%F{green}╠══════════════════════════════════════════════════════════════════════════╣%f"
  print -P "%F{green}║%f *%F{yellow}Signum Machina%f* - %F{cyan}Contact avec l'Omnissiah établi%f…                      %F{green}║%f"
  print -P "%F{green}╚══════════════════════════════════════════════════════════════════════════╝%f"
}

# Appeler la fonction d'accueil au démarrage
mecanicus_greeting

# Personnaliser le prompt de Zsh avec couleurs
PROMPT='%F{green}╔[%F{yellow}%D{%H:%M:%S}%f%F{green}]─[USER: %F{yellow}%n%f%F{green}]─[DIR: %F{yellow}%~%f%F{green}]%f
%F{green}╚═══>%f '

# Charger des plugins utiles (si souhaité)
plugins=(git)

# Afficher l'historique avec des commandes utiles (par exemple l'alias 'h' pour afficher l'historique)
alias h='history | tail -20'

# Activer l'auto-complétion
autoload -Uz compinit && compinit


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
# pokemon-colorscripts --no-title -r

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
