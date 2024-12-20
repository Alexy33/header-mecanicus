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

  # Récupérer l'utilisation de la RAM (%)
  ram_usage=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')

  # Citations du Mechanicus en français
  local citations=(
    "La chair est faible, mais la machine est pure."
    "La connaissance est pouvoir, dissimule-la bien."
    "Béni soit l'esprit sans doute."
    "L'Omnimessie voit tout."
    "Grâce à la machine, je transcende."
    "Seuls les fidèles foulent le chemin de la connaissance."
    "Purge les impurs, sanctifie la machine."
    "Loué soit l'Omnimessie, ne crains pas l'étranger."
    "Connaître la machine, c'est toucher le divin."
    "Le Dieu-Machine veille sur nous tous."
  )

  # Sélectionner une citation aléatoire
  local random_index=$((RANDOM % ${#citations[@]}))
  local random_citation=${citations[$random_index]}

  # Fonction pour diviser le texte en lignes de longueur fixe (70 caractères max)
  function split_text() {
    local text="$1"
    local max_length=70
    while [[ ${#text} -gt $max_length ]]; do
      local line="${text:0:$max_length}"
      local cut_at=$(echo "$line" | awk '{print length($0)-length($NF)}')
      printf "%-${max_length}s\n" "${text:0:$cut_at}"
      text="${text:$cut_at}"
    done
    printf "%-${max_length}s\n" "$text"
  }

  # Fonction pour générer une barre de progression avec largeur fixe
  function progress_bar() {
    local usage=$1
    local total=50  # longueur de la barre
    local filled=$(($usage * $total / 100))  # portion remplie
    local empty=$(($total - $filled))  # portion vide

    # Générer les blocs remplis et vides sans retour à la ligne
    local bar_filled=$(repeat $filled echo -n '█')
    local bar_empty=$(repeat $empty echo -n '▒')

    # Afficher la barre avec couleurs sur la même ligne, avec pourcentage formaté pour 3 caractères fixes
    print -P "%F{yellow}${bar_filled}%F{cyan}${bar_empty} %F{white}$(printf '%3d' $usage)%%"
  }

  # Fixer la largeur des colonnes et des données dynamiques pour une taille fixe dans le cadran
  function fixed_length() {
    local text="$1"
    local max_length=40
    printf "%-${max_length}s" "$text"
  }

  # Récupérer la date et l'heure avec un format fixe
  local current_date=$(date '+%A %d %B %Y')
  local current_time=$(date '+%H:%M:%S')
  local username=$(whoami)
  local system_name=$(uname -n)

  # Afficher l'écran d'accueil
  print -P "%F{green}╔══════════════════════════════════════════════════════════════════════════╗%f"
  print -P "%F{green}║%f  %F{cyan}Adeptus Mechanicus - Cogitateur Sacré%f                                   %F{green}║%f"
  print -P "%F{green}║%f  Connexion au %F{yellow}Noosphere%f…                                                 %F{green}║%f"
  print -P "%F{green}╠══════════════════════════════════════════════════════════════════════════╣%f"
  print -P "%F{green}║%f > %F{cyan}Invoquer Code Machine%f...                                               %F{green}║%f"
  print -P "%F{green}║%f > %F{cyan}Vérification des rites de machine%f...                                   %F{green}║%f"
  print -P "%F{green}║%f > %F{cyan}Sanctification de l'esprit-machine en cours%f...                         %F{green}║%f"
  print -P "%F{green}╟──────────────────────────────────────────────────────────────────────────╢%f"
  print -P "%F{green}║%f [Date] : %F{yellow}$(fixed_length "$current_date")%f                        %F{green}║%f"
  print -P "%F{green}║%f [Heure] : %F{yellow}$(fixed_length "$current_time")%f                       %F{green}║%f"
  print -P "%F{green}║%f [Utilisateur] : %F{yellow}$(fixed_length "$username")%f                 %F{green}║%f"
  print -P "%F{green}║%f [Système] : %F{yellow}$(fixed_length "$system_name")%f                     %F{green}║%f"
  print -P "%F{green}╟──────────────────────────────────────────────────────────────────────────╢%f"
  print -P "%F{green}║%f %F{red}Disque :%f $(progress_bar $disk_usage)%%          %F{green}║%f"
  print -P "%F{green}║%f %F{cyan}CPU :%f    $(progress_bar ${cpu_usage%.*})%%          %F{green}║%f"
  print -P "%F{green}║%f %F{blue}RAM :%f    $(progress_bar $ram_usage)%%          %F{green}║%f"
  print -P "%F{green}╠══════════════════════════════════════════════════════════════════════════╣%f"
  split_text "**$random_citation**" | while IFS= read -r line; do
      print -P "%F{green}║%f %F{magenta}$line%f   %F{green}║%f"
  done
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
