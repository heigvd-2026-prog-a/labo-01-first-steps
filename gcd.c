/**
 * Euclidian Algorithm
 *
 * The Euclidean algorithm (also called Euclid's algorithm) is an
 * algorithm to determine the greatest common divisor of two integers.
 *
 * Usage: ./gcd <a> <b>
 */
#include <stdio.h>  // Déclare printf et fprintf pour écrire sur la console
#include <stdlib.h> // Déclare atoi et les constantes EXIT_SUCCESS/EXIT_FAILURE

int gcd(int a, int b) { // Fonction recevant deux entiers a et b et
                        // retournant leur plus grand commun diviseur
    int r;              // Mémorise temporairement la valeur de b
    while (b != 0) {    // Tant que le reste de la division n'est pas nul...
        r = b;          // ...conserve le diviseur courant,
        b = a % b;      // le remplace par le reste de la division de a par b
        a = r;          // et fait de l'ancien diviseur le nouveau dividende
    }
    return a;           // Le dernier reste non nul est le PGCD
}

int main(int argc, char* argv[]) { // Point d'entrée : argc compte les arguments,
                                   // argv les contient sous forme de chaînes
    if (argc != 3) { // Le nom du programme suivi de deux nombres est attendu
        fprintf(stderr, "Usage: %s <a> <b>\n", argv[0]); // Explique l'usage
        return EXIT_FAILURE; // Signale l'échec au système d'exploitation
    }

    int a = atoi(argv[1]); // Convertit le premier argument en entier
    int b = atoi(argv[2]); // Convertit le second argument en entier

    int result = gcd(a, b); // Calcule le PGCD des deux nombres

    printf("%d\n", result); // Affiche le résultat suivi d'un retour à la ligne

    return EXIT_SUCCESS; // Signale que le programme s'est terminé sans erreur
}
