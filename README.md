# sergeVim
SergeVim est une config vim faite pour 42 avec des outils pour mettre a la norme et un generateur de header.
Pour utiliser le header en dehors de 42 il faut modifier les variables PATH USER et MAIL (export USER=name).

## Installation
ServeVim est très simple a installer:
Entrez la commande suivante dans le shell et attendez que sergeVim soit installé.
>`git clone https://github.com/tarama78/sergeVim && cd sergeVim && ./install.sh`
  
## Mise a jour
SergeVim est sans cesse mis a jour. N'hesitez pas a mettre le mettre a jour en enttrant la commande ci dessous.
>`./update_vim.sh`

## Parametre
Vous pouvez parametrer votre sergeVim en modifiant les variables du fichier `~/.vim/sergeVim/param.vim`. Lorsque vous mettez sergeVim a jour vos parametres ne seronts pas modifier saut si vous mettez l'option `--param` : `./update_vim.sh --param`. Dans ce cas la vos parametres seront reinitialisés.

## Aide
Pour obtenir de l'aide tappez `,h` en mode normal dans vim. Cela ouvrira un fichier d'aide dans un nouvel onglet avec tout les racourcis dedant.
