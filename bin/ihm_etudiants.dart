import 'ihm_principale.dart';

class IHMEtudiants {
  static void menu() {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Etudiants");
      print("0- Annuler");
      choix = IHMprincipale.choixMenu(0);
    }
  }
}
