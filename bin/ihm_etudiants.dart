import 'db_etudiant.dart';
import 'etudiant.dart';
import 'ihm_principale.dart';

class IHMEtudiants {
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Etudiants");
      print("1- Afficher des données de la table");
      print("2- Inserer une données dans la table");
      print("3- Modifier une données dans la table");
      print("4- Supprimer une données dans la tables");
      print("5- Supprimer toutes les données dans la tables");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMEtudiants.menuSelectEtu();
      } else if (choix == 2) {
        await IHMEtudiants.insertEtudiant();
      } else if (choix == 3) {
        await IHMEtudiants.updateEtudiant();
      } else if (choix == 4) {
        await IHMEtudiants.deleteEtudiant();
      } else if (choix == 5) {
        await IHMEtudiants.deleteAllEtudiants();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectEtu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Etudiants");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(2);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMEtudiants.selectEtudiant();
      } else if (choix == 2) {
        print("Fonction non implémentée.");
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Etudiant
  static Future<void> insertEtudiant() async {
    String nom = IHMprincipale.saisieString();
    String email = IHMprincipale.saisieString();
    int age = IHMprincipale.saisieInt();
    if (IHMprincipale.confirmation()) {
      await DBEtudiant.insertEtudiant(nom, email, age);
      print("Etudiant inséré dans la table.");
      print("--------------------------------------------------");
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour mettre a jour un Etudiant selon ID
  static Future<void> updateEtudiant() async {
    print("Quelle Etudiant voulez vous mettre à jour ?");
    int id = IHMprincipale.saisieID();
    if (await DBEtudiant.exist(id)) {
      String nom = IHMprincipale.saisieString();
      String email = IHMprincipale.saisieString();
      int age = IHMprincipale.saisieInt();
      if (IHMprincipale.confirmation()) {
        await DBEtudiant.updateEtudiant(id, nom, email, age);
        print("Etudiant $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("L'étudiant $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour afficher un Etudiant selon ID
  static Future<void> selectEtudiant() async {
    print("Quelle Etudiant voulez vous afficher ?");
    int id = IHMprincipale.saisieID();
    if (IHMprincipale.confirmation()) {
      Etudiant etu = await DBEtudiant.selectEtudiant(id);
      if (!etu.estNull()) {
        IHMprincipale.afficherUneDonnee(etu);
        print("Fin de l'opération.");
        print("--------------------------------------------------");
      } else {
        print("L'etudiant $id n'existe pas");
        print("Fin de l'opération.");
        print("--------------------------------------------------");
      }
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

// action pour supprimer un Etudiant selon ID
  static Future<void> deleteEtudiant() async {
    print("Quelle Etudiant voulez vous supprimer ?");
    int id = IHMprincipale.saisieID();
    if (IHMprincipale.confirmation()) {
      DBEtudiant.deleteEtudiant(id);
      print("Etudiant $id supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour supprimer les Etudiants
  static Future<void> deleteAllEtudiants() async {
    if (IHMprincipale.confirmation()) {
      DBEtudiant.deleteAllEtudiant();
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
