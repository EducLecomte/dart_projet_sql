import 'dart:io';

import 'db_config.dart';
import 'ihm_enseignants.dart';
import 'ihm_etudiants.dart';

class IHMprincipale {
  static void titre() {
    print("");
    print("Bienvenue dans :");
    print("Bac à sable - projet SQL");
  }

  static void quitter() {
    print("Au revoir !");
  }

  // methodes de saisie
  // retourne un chiffre entre 0 et nbChoix pour les menus
  static int choixMenu(int nbChoix) {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir une action (0-$nbChoix)");
      try {
        i = int.parse(stdin.readLineSync().toString());
        if (i >= 0 && i <= nbChoix) {
          saisieValide = true;
        } else {
          print("La saisie ne correspond à aucune action.");
        }
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // retourne un boolean pour demande de confirmation
  static bool confirmation() {
    bool saisieValide = false;
    bool confirme = false;
    while (!saisieValide) {
      print("Confirmer vous l'action ? (o/n)");
      String reponse = stdin.readLineSync().toString();
      if (reponse.toLowerCase() == "o") {
        saisieValide = true;
        confirme = true;
      } else if (reponse.toLowerCase() == "n") {
        saisieValide = true;
        print("Annulation.");
      } else {
        print("Erreur dans la saisie.");
      }
    }
    return confirme;
  }

  // retourne un string pour saisie de chaine de caractère
  static String saisieString() {
    bool saisieValide = false;
    String s = "";
    while (!saisieValide) {
      print("> Veuillez saisir une chaine de caractère :");
      try {
        s = stdin.readLineSync().toString();
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

  // methode des menus et actions
  // menu d'accueil
  static int menu() {
    int choix = -1;
    while (choix != 0) {
      print("> Que voulez vous faire ?");
      print("1- Gestion de la BDD");
      print("2- Gestion de la table Etudiants");
      print("3- Gestion de la table Enseignants");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(3);
      if (choix == 1) {
        IHMprincipale.menuBDD();
      } else if (choix == 2) {
        IHMEtudiants.menu();
      } else if (choix == 3) {
        IHMEnseignant.menu();
      }
    }
    return 0;
  }

  // menu pour la gestion basic de la BDD
  static void menuBDD() {
    int choix = -1;
    while (choix != 0) {
      print("> Que voulez vous faire ?");
      print("1- Création des tables de la BDD");
      print("2- Verification des tables de la BDD");
      print("3- Supprimer une table dans la BDD");
      print("4- Supprimer toutes les tables dans la BDD");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(4);
      if (choix == 1) {
        IHMprincipale.createTable();
      } else if (choix == 2) {
        IHMprincipale.checkTable();
      } else if (choix == 3) {
        IHMprincipale.checkTable();
      } else if (choix == 4) {
        IHMprincipale.checkTable();
      }
    }
  }

  static void createTable() async {
    print("Création des tables manquantes dans la BDD ...");
    await DBConfig.createTables();
    print("Fin de l'opération.");
  }

  static void checkTable() async {
    print("Verification des tables dans la BDD ...");
    if (await DBConfig.checkTables()) {
      print("Toutes les tables sont présentes dans la BDD.");
    }
    print("Fin de l'opération.");
  }

  static void deleteTable() async {}
  static void deleteAllTables() async {}
}
