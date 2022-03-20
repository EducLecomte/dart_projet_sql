import 'dart:io';

import 'db_config.dart';
import 'ihm_enseignants.dart';
import 'ihm_etudiants.dart';

class IHMprincipale {
  static void titre() {
    print("");
    print("Bienvenue dans :");
    print("Bac à sable - projet SQL");
    print("--------------------------------------------------");
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
  static Future<int> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu Principal");
      print("1- Gestion de la BDD");
      print("2- Gestion de la table Etudiants");
      print("3- Gestion de la table Enseignants");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(3);
      print("--------------------------------------------------");
      if (choix == 1) {
        await IHMprincipale.menuBDD();
      } else if (choix == 2) {
        await IHMEtudiants.menu();
      } else if (choix == 3) {
        await IHMEnseignant.menu();
      }
    }
    return 0;
  }

  // menu pour la gestion basic de la BDD
  static Future<void> menuBDD() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion BDD");
      print("1- Création des tables de la BDD");
      print("2- Verification des tables de la BDD");
      print("3- Afficher les tables de la BDD");
      print("4- Supprimer une table dans la BDD");
      print("5- Supprimer toutes les tables dans la BDD");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMprincipale.createTable();
      } else if (choix == 2) {
        await IHMprincipale.checkTable();
      } else if (choix == 3) {
        await IHMprincipale.selectTable();
      } else if (choix == 4) {
        await IHMprincipale.deleteTable();
      } else if (choix == 5) {
        await IHMprincipale.deleteAllTables();
      }
    }
    print("Retour menu principal.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour creer les tables
  static Future<void> createTable() async {
    print("Création des tables manquantes dans la BDD ...");
    await DBConfig.createTables();
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour vérifier les tables
  static Future<void> checkTable() async {
    print("Verification des tables dans la BDD ...");
    if (await DBConfig.checkTables()) {
      print("Toutes les tables sont présentes dans la BDD.");
    } else {
      print("Il manque des tables dans la BDD.");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour afficher les tables
  static Future<void> selectTable() async {
    List<String> listTable = await DBConfig.selectTables();
    print("Liste des tables :");
    for (var table in listTable) {
      print(table);
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour supprimer une table
  static Future<void> deleteTable() async {
    print("Quelle table voulez vous supprimer ?");
    String table = IHMprincipale.saisieString();
    if (IHMprincipale.confirmation()) {
      DBConfig.dropTable(table);
      print("Table supprimée.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

// action pour supprimer les tables
  static Future<void> deleteAllTables() async {
    if (IHMprincipale.confirmation()) {
      DBConfig.dropAllTable();
      print("Tables supprimées.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
