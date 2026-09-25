# 👋 Laboratoire 01 — Premiers pas

| Type       | Description                                  |
| ---------- | -------------------------------------------- |
| Durée      | 2 × 45 minutes + travail à la maison         |
| Rendu      | Sur GitHub, via HEIG-Classroom               |
| Format     | Travail individuel                           |
| Évaluation | Tests automatisés et relecture du code       |

Ce premier travail pratique a pour but de vous familiariser avec l'environnement de développement, Visual Studio Code, et de compiler votre tout premier programme. Au fil des laboratoires, les consignes se feront plus succinctes et vous gagnerez en autonomie ; pour l'heure, avançons pas à pas.

À l'issue de ce travail pratique, vous saurez :

- récupérer les fichiers sources d'un travail pratique depuis GitHub (*clone*) ;
- modifier des fichiers et en ajouter de nouveaux ;
- enregistrer vos modifications (*commit*) et les publier sur GitHub (*push*) ;
- compiler un programme et interpréter les messages du compilateur ;
- tester un programme et le déboguer pas à pas ;
- identifier le rôle des différents fichiers qui composent un projet d'Info1.

## Début d'un laboratoire

Aujourd'hui, l'immense majorité des développeurs gèrent le code source de leurs projets avec **Git**. Git n'est rien d'autre qu'une base de données locale, logée dans un répertoire caché nommé `.git` à la racine du projet, qui conserve l'historique complet de chaque modification.

| Rang | Système de gestion de versions | Part d'utilisation (ordre de grandeur) |
| ---- | ------------------------------ | -------------------------------------- |
| 1    | Git                            | 95 %                                   |
| 2    | Subversion                     | 3 %                                    |
| 3    | Perforce                       | 1 %                                    |
| 4    | Mercurial                      | 1 %                                    |

Dans les années 1990, les développeurs qui voulaient collaborer s'échangeaient leur code par courriel, voire par disquettes envoyées par la poste. On recourt désormais à des plateformes collaboratives bâties autour de Git, dont voici les principales :

| Rang | Plateforme                | Part d'utilisation (ordre de grandeur) |
| ---- | ------------------------- | -------------------------------------- |
| 1    | GitHub                    | 78 %                                   |
| 2    | GitLab                    | 12 %                                   |
| 3    | Bitbucket                 | 6 %                                    |
| 4    | Azure DevOps              | 3 %                                    |
| 5    | Autres (Gitea, Forgejo…)  | 1 %                                    |

Pour faciliter l'organisation des laboratoires, la HEIG-VD a développé [HEIG-Classroom](https://classroom.chevallier.io). Cette plateforme distribue les travaux pratiques, dialogue avec GitHub, recueille les rendus et en facilite la correction.

La première étape consiste donc à vous connecter à HEIG-Classroom, puis à accepter le laboratoire. La plateforme crée alors pour vous, sur GitHub, un **dépôt** (*repository*) : un espace de stockage en ligne qui accueillera votre code source et que vous pouvez consulter depuis votre navigateur.

Une fois sur la page GitHub de votre dépôt, récupérez l'adresse qui permet de le *cloner*, c'est-à-dire d'en obtenir une copie sur votre ordinateur :

1. cliquez sur le bouton vert `<> Code` ;
2. sélectionnez l'onglet `Local` ;
3. choisissez `SSH` ;
4. cliquez sur l'icône de copie pour placer l'adresse dans le presse-papiers.

![copy-clone-link](assets/copy-clone-link.png)

## Clonage du dépôt

Lors du travail précédent, vous avez installé WSL (Linux) et Git. Ouvrez à présent un terminal Linux et saisissez la commande `git clone` suivie de l'adresse copiée depuis GitHub ; un clic droit suffit à la coller dans le terminal. Voici à quoi ressemble l'opération :

```console
$ git clone git@github.com:heig-tin-info/labo-01-first-steps-emmett-brown.git
Cloning into 'labo-01-first-steps-emmett-brown'...
remote: Enumerating objects: 24, done.
remote: Counting objects: 100% (24/24), done.
remote: Compressing objects: 100% (22/22), done.
remote: Total 24 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (24/24), 197.60 KiB | 2.53 MiB/s, done.
```

Décortiquons cette commande. Le `$` en début de ligne est l'**invite de commande** (*prompt*) : il signale que le terminal attend vos instructions et ne doit pas être recopié. `git` est le nom du programme appelé, `clone` l'une de ses sous-commandes, et le dernier argument désigne le dépôt à cloner.

Git rend compte de l'avancement du clonage au fil de son exécution. Le point important est que la dernière ligne se termine par `done` : tout s'est bien passé.

Entrez ensuite dans le répertoire du projet avec la commande `cd` (*change directory*), suivie du nom du répertoire indiqué par la commande précédente :

```console
cd labo-01-first-steps-emmett-brown
```

> [!TIP]
> Tapez simplement `cd lab` puis appuyez sur <kbd>Tab</kbd> : le terminal complète automatiquement le reste du nom. C'est fort pratique lorsque les noms de répertoires sont longs.

Vous pouvez dès lors lancer votre éditeur de code, Visual Studio Code. N'oubliez pas le point `.` après le nom de la commande : il désigne le *répertoire courant*, c'est-à-dire celui du projet.

```console
code .
```

Visual Studio Code s'exécute sous Windows, mais se connecte à votre WSL au moyen d'une connexion à distance (*remote connection*). Un indicateur situé en bas à gauche de la fenêtre en affiche l'état, par exemple `WSL: Ubuntu`. Au lancement, vous verrez l'éditeur établir cette connexion :

![open-remote](assets/open-remote.png)

> [!NOTE]
> Si la connexion ne s'établit pas, il vous manque probablement l'extension **WSL**. Installez-la depuis le panneau `Extensions` de Visual Studio Code, puis redémarrez l'éditeur.

## Installation des extensions

Visual Studio Code est un outil très polyvalent dont on étend les fonctionnalités au gré des besoins grâce à des *extensions*. Pour disposer de tout l'outillage nécessaire au développement en C, installez celles qui suivent, si ce n'est déjà fait. Le raccourci <kbd>Ctrl</kbd>+<kbd>Maj</kbd>+<kbd>X</kbd> ouvre le panneau des extensions.

**C/C++** (Microsoft) — Fournit l'interface avec le débogueur, indispensable pour exécuter votre programme pas à pas.

**clangd** — Offre une autocomplétion pertinente et signale les erreurs au fil de la frappe. Si l'extension vous propose de désactiver l'IntelliSense de l'extension C/C++, acceptez : les deux feraient doublon.

**EditorConfig** — Applique automatiquement les conventions propres à chaque type de fichier (largeur d'indentation, encodage, fins de ligne, etc.), décrites dans le fichier `.editorconfig`.

> [!TIP]
> Ces extensions sont recommandées par le projet lui-même : à l'ouverture du dossier, Visual Studio Code vous propose de les installer en un clic.

Le raccourci <kbd>Ctrl</kbd>+<kbd>Maj</kbd>+<kbd>E</kbd> vous ramène ensuite à l'explorateur de fichiers.

## Structure du projet

Prenez connaissance de l'arborescence du laboratoire, reproduite ci-dessous. Pour l'obtenir vous-même, ouvrez un terminal dans Visual Studio Code avec <kbd>Ctrl</kbd>+<kbd>J</kbd>, puis tapez la commande `tree` :

```text
.
├── Makefile          # Les directives de compilation
├── README.md         # La donnée du laboratoire, au format Markdown
├── assets            # Les images illustrant la donnée
├── criteria.yml      # Les critères d'évaluation du travail
├── gcd.c             # Le programme C à corriger et à annoter
└── tests             # Les tests automatisés du laboratoire
    └── test_gcd.py   # Les tests du programme gcd.c
```

> [!NOTE]
> Si le programme `tree` n'est pas installé dans votre WSL, installez-le avec `sudo apt install tree`.

D'autres fichiers, dont le nom commence par un point, sont masqués par défaut (`tree -a` les affiche) : ils configurent l'éditeur (`.vscode`), Git (`.gitignore`) ou l'intégration continue (`.github`). Vous n'avez pas à y toucher.

Pour l'heure, seul le fichier `gcd.c` nous intéresse. Il implémente l'algorithme d'Euclide, qui calcule le plus grand commun diviseur (PGCD, *greatest common divisor* en anglais) de deux entiers. Votre mission : corriger ce programme et le compiler.

Car le programme qui vous est fourni ne compile pas : il est truffé d'erreurs, et de plusieurs natures :

- des erreurs de syntaxe ;
- des erreurs de logique ;
- des erreurs de style.

## Compilation

Depuis le terminal, tentez de compiler le programme avec le compilateur `gcc`. Vous obtiendrez plusieurs messages d'erreur :

```console
$ gcc gcd.c
gcd.c: In function 'gcd':
gcd.c:13:5: error: 'r' undeclared (first use in this function)
   13 |     r = b;
      |     ^
gcd.c:13:5: note: each undeclared identifier is reported only once for each function it appears in
gcd.c: In function 'main':
gcd.c:30:5: error: implicit declaration of function 'printf' [-Wimplicit-function-declaration]
   30 |     printf("%d\n", result + 5);
      |     ^~~~~~
gcd.c:9:1: note: include '<stdio.h>' or provide a declaration of 'printf'
    8 | #include <string.h>
  +++ |+#include <stdio.h>
    9 |
gcd.c:32:13: error: expected ';' before '}' token
   32 |     return 0
      |             ^
      |             ;
   33 | }
      | ~
```

Chaque message suit le même schéma : le fichier, la ligne et la colonne concernés (`gcd.c:13:5`), la gravité (`error`, `warning` ou `note`), puis une description du problème, suivie de la ligne fautive dont l'emplacement exact est souligné par un `^`. Le compilateur va parfois jusqu'à suggérer la correction, comme ici l'ajout de `#include <stdio.h>`.

Votre objectif est naturellement de corriger ces erreurs en interprétant les messages. La démarche est simple :

1. compilez ;
2. corrigez la première erreur signalée et enregistrez le fichier ;
3. recommencez tant que la compilation échoue.

> [!TIP]
> Traitez toujours les erreurs dans l'ordre : une seule faute peut en provoquer plusieurs autres en cascade, qui disparaîtront d'elles-mêmes une fois la première corrigée.

Vous pouvez également vous appuyer sur l'onglet `Problems` de Visual Studio Code, qui recense les erreurs détectées par les extensions installées. Le raccourci <kbd>Ctrl</kbd>+<kbd>Maj</kbd>+<kbd>M</kbd> l'affiche.

![problems](assets/problems.png)

Un double clic sur une erreur vous conduit directement à la ligne incriminée.

## Compilation automatique

En pratique, on n'appelle guère `gcc` sans lui passer d'**options de compilation**. L'option `-std=c11`, par exemple, impose le respect de la norme **C11** (ISO/IEC 9899:2011) ; `-Wall -Wextra` activent la plupart des avertissements, et `-Werror` les transforme en erreurs afin qu'aucun ne passe inaperçu. Pour ne pas avoir à retaper ces options, le développeur consigne toute la procédure de compilation dans un fichier nommé `Makefile`.

Dans ce cours, il ne vous sera jamais demandé d'écrire un `Makefile` ; en revanche, il est essentiel que vous sachiez vous en servir. Il suffit pour cela d'exécuter le programme `make` dans le répertoire qui contient le `Makefile` :

```console
$ make
cc -std=c11 -g -Wall -Wextra -Werror gcd.c -o gcd
```

Le programme `gcd` est produit. Exécutez-le en préfixant son nom de `./`, qui indique qu'il se trouve dans le répertoire courant :

```console
$ ./gcd 12 6
11
```

Étrange : le programme affiche 11 alors que le plus grand commun diviseur de 12 et 6 est 6. Le programme compile, certes, mais il reste des erreurs de logique. Saurez-vous les débusquer ?

Pour vous aider, le laboratoire est accompagné de **tests automatisés** qui exécutent votre programme avec de nombreuses valeurs et comparent ses réponses aux résultats attendus. Ils s'appuient sur `pytest`, que vous installez une fois pour toutes :

```console
sudo apt install python3-pytest
```

Lancez ensuite les tests avec :

```console
$ make test
pytest -v
...
tests/test_gcd.py::test_prints_the_greatest_common_divisor[42-36-6] FAILED [  5%]
tests/test_gcd.py::test_prints_the_greatest_common_divisor[12-6-6] FAILED [ 11%]
...
========================= 15 failed, 3 passed in 0.06s =========================
make: *** [Makefile:12: test] Error 1
```

Chaque ligne correspond à un test : `PASSED` s'il réussit, `FAILED` s'il échoue, accompagné en fin de rapport d'une explication de l'écart constaté. Ouvrez le fichier `tests/test_gcd.py` : il énonce sans ambiguïté ce que l'on attend de votre programme, y compris dans les cas particuliers.

Votre objectif, bien entendu, est que tous les tests passent.

## Débogage depuis Visual Studio Code

Pour un petit programme, relire le code ou compiler à la main suffit souvent à trouver une erreur. Pour de plus gros programmes, on recourt à un outil dédié : le **débogueur**, qui permet d'exécuter le programme pas à pas et d'observer l'évolution de ses variables.

Assurez-vous d'abord qu'un débogueur est installé sur votre système. Depuis le terminal (<kbd>Ctrl</kbd>+<kbd>J</kbd>), installez `gdb` (*GNU Debugger*) :

```console
sudo apt install gdb
```

Dès lors, le raccourci <kbd>F5</kbd> compile le programme avec `make`, puis le lance sous le contrôle du débogueur.

Si le message ci-dessous apparaît, c'est que votre programme ne compile toujours pas : corrigez d'abord les erreurs de compilation.

![Encore des erreurs](assets/errors.png)

Si c'est le message suivant qui s'affiche, `gdb` n'est pas installé dans votre WSL : installez-le avec la commande `sudo apt install gdb`.

![Pas de débogueur](assets/no-debugger.png)

Si tout se passe bien, la console de débogage affiche une sortie semblable à celle-ci :

```text
Loaded '/lib64/ld-linux-x86-64.so.2'. Symbols loaded.
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/x86_64-linux-gnu/libthread_db.so.1".
Loaded '/usr/lib/x86_64-linux-gnu/libc.so.6'. Symbols loaded.
[Inferior 1 (process 129149) exited normally]
The program '/home/ycr/labo-01-first-steps/gcd' has exited with code 0 (0x00000000).
```

Les lignes `Loaded` indiquent que le débogueur a chargé les *symboles de débogage*, ces informations qui lui permettent de faire le lien entre le programme compilé et votre code source. La dernière ligne, `has exited with code 0`, signifie que le programme s'est terminé normalement.

Tout l'intérêt du débogueur, cependant, est de pouvoir **suspendre** l'exécution pour examiner l'état interne du programme. Il faut pour cela poser un **point d'arrêt** (*breakpoint*), par exemple à la ligne 12 de `gcd.c` : cliquez dans la marge, à gauche du numéro de ligne, et un point rouge apparaît.

![breakpoint](assets/breakpoint.png)

Relancez le débogueur avec <kbd>F5</kbd> : le programme s'interrompt à la ligne 12. Le panneau `Variables`, à gauche de la fenêtre, affiche alors la valeur de `a`, `b` et `r` ; survoler le nom d'une variable dans le code source la révèle également.

![variables](assets/debugging.png)

Vous pouvez désormais avancer instruction par instruction et observer l'évolution des variables :

| Raccourci                          | Action                                                      |
| ---------------------------------- | ----------------------------------------------------------- |
| <kbd>F10</kbd>                     | Exécuter la ligne courante (*step over*)                    |
| <kbd>F11</kbd>                     | Entrer dans la fonction appelée (*step into*)               |
| <kbd>F5</kbd>                      | Poursuivre jusqu'au prochain point d'arrêt (*continue*)     |
| <kbd>Maj</kbd>+<kbd>F5</kbd>       | Interrompre le débogage                                     |

Cette méthode vous permet d'analyser finement le comportement du programme et d'en corriger les défauts. Remémorez-vous l'algorithme d'Euclide vu en cours et déroulez-le sur papier : quelles valeurs `a`, `b` et `r` devraient-elles prendre à chaque itération de la boucle ? Confrontez ensuite vos prédictions à ce qu'affiche le débogueur ; c'est là où elles divergent que se cache l'erreur.

Votre objectif est de corriger toutes les erreurs restantes.

## Modifier les arguments du programme

Vous l'aurez remarqué : sous le débogueur, le programme est appelé avec les arguments 42 et 36. Vous pouvez les changer : ouvrez le fichier `launch.json` avec <kbd>Ctrl</kbd>+<kbd>P</kbd>, tapez `launch.json` puis validez avec <kbd>Entrée</kbd>. Les arguments figurent dans la clé `args` :

```json
"args": ["42", "36"],
```

Essayez d'autres valeurs, en particulier des cas limites (un nombre nul, deux nombres égaux, deux nombres premiers entre eux…), pour vous assurer que votre programme se comporte correctement en toutes circonstances.

## Annotation du programme

Pour vous assurer d'avoir bien compris votre premier programme, annotez **chaque ligne** d'un commentaire expliquant son rôle. Par exemple :

```c
#include <stdlib.h> // Inclut la bibliothèque standard, qui déclare la fonction atoi

int gcd(int a, int b) { // Déclare la fonction gcd, qui reçoit deux entiers
                        // a et b et retourne un entier
    int r;              // Déclare la variable r, qui mémorisera ...
```

Un commentaire utile ne se contente pas de paraphraser la syntaxe (« on affecte b à r ») : il explique *pourquoi* la ligne est là et ce qu'elle apporte au programme.

Pour les explications plus longues, recourez aux commentaires multilignes :

```c
/*
 * Ceci est un commentaire multiligne,
 * propice aux explications plus détaillées.
 */
```

Si le sens de certaines lignes vous échappe, cherchez la réponse dans la documentation ou sur Internet ; à défaut, n'hésitez pas à interroger vos camarades ou l'équipe enseignante.

## Enregistrer vos modifications (*commit*)

Une fois toutes les étapes précédentes accomplies, il est temps de soumettre votre travail sur GitHub. Commencez par enregistrer vos modifications dans l'historique de Git au moyen d'un **commit** :

```console
$ git commit -am "Fix and annotate the gcd program"
[master 5e1d2c4] Fix and annotate the gcd program
 1 file changed, 24 insertions(+), 18 deletions(-)
```

L'option `-a` (*all*) demande à Git de prendre en compte toutes les modifications apportées aux fichiers déjà suivis, et l'option `-m` (*message*) indique que l'argument suivant est le message qui décrit ces modifications. Comme le permettent les conventions POSIX, les deux options peuvent être accolées : `-am`.

> [!TIP]
> Un bon message de commit est bref, précis et décrit *ce que* le commit change : « Fix the Euclidean loop » plutôt que « modifs » ou « update ». N'hésitez pas à faire un commit à chaque étape franchie.

Si Git refuse d'exécuter la commande, c'est vraisemblablement que vous n'avez pas encore renseigné votre identité :

```console
git config --global user.name "Emmett Lathrop Brown"
git config --global user.email emmett.brown@heig-vd.ch
```

## Publier vos modifications (*push*)

Le commit n'existe pour l'instant que sur votre ordinateur. Pour le publier sur GitHub, utilisez la commande `git push` :

```console
$ git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 1.02 KiB | 1.02 MiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
To github.com:heig-tin-info/labo-01-first-steps-emmett-brown.git
   dd54203..5e1d2c4  master -> master
```

Retournez ensuite sur GitHub pour vérifier que votre travail y figure bel et bien.

## Évaluation

À chaque `push`, GitHub compile votre programme et exécute les tests automatisés : c'est ce qu'on appelle l'**intégration continue**. Le résultat est visible dans l'onglet `Actions` de votre dépôt, ainsi que sur HEIG-Classroom, sous la forme d'une note **indicative**. Une coche verte signifie que la compilation et les tests ont réussi ; une croix rouge vous invite à consulter le détail de l'exécution pour comprendre ce qui a échoué.

La note définitive est établie à l'échéance du laboratoire, à partir des critères énoncés dans `criteria.yml` : fonctionnement du programme, correction des erreurs, qualité et exactitude des annotations, indentation et qualité de vos commits.

> [!WARNING]
> Les fichiers `README.md`, `criteria.yml` et `.github/workflows/grading.yml` sont protégés : toute modification de votre part est automatiquement annulée par la plateforme. Ne les modifiez pas.
