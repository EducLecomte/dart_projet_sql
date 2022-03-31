import 'package:mysql1/mysql1.dart';

import 'ihm_principale.dart';

class IHMEnseignant {
  static Future<void> menu(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Enseignants");
      print("0- Annuler");
      choix = IHMprincipale.choixMenu(0);
      print("--------------------------------------------------");
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }
}
