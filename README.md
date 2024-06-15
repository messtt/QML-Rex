 
# Jeu du T-Rex en QML/C++

Bienvenue dans QML-Rex ! Ce projet est une réimplémentation du célèbre jeu du dinosaure de Google Chrome, développé quasiment entièrement en QML.

## Aperçu

Le jeu du T-Rex est un jeu d'arcade simple où le joueur contrôle un dinosaure qui doit sauter par-dessus des obstacles pour éviter de les heurter. Le jeu devient progressivement plus rapide et plus difficile au fur et à mesure que le joueur progresse.

## Fonctionnalités

- Graphismes simples et rétro
- Contrôles de jeu intuitifs
- Difficulté progressive
- Création en QML/C++

## Prérequis

- [Qt 5.x](https://www.qt.io/download) ou supérieur

## Installation

1. **Clonez le dépôt :**

    ```sh
    git clone https://github.com/messtt/QML-Rex.git
    cd  QML-Rex
    ```

2. **Installez les dépendances :**

    Assurez-vous d'avoir Qt installé et configuré sur votre système. Ajoutez Qt à votre PATH si nécessaire.

3. **Compilez le projet :**


    ```sh
    qmake
    make
    ./QML-Rex
    ```

    Alternativement, vous pouvez ouvrir le projet avec Qt Creator et le compiler directement.

## Utilisation

Pour exécuter le jeu après l'avoir compilé, lancez l'exécutable généré dans le répertoire `build`. Vous pouvez également exécuter le jeu directement depuis Qt Creator si vous l'utilisez pour la compilation.

**Contrôles du jeu :**

- **Espace** ou **Flèche haut** : Sauter
- **Flèche bas** : Se baisser
