import 'ihm_principale.dart';

class IHMEnseignant {
  static void menu() {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Enseignants");
      print("0- Annuler");
      choix = IHMprincipale.choixMenu(0);
    }
  }
}
