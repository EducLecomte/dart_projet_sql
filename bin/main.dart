import 'ihm_principale.dart';

void main(List<String> arguments) async {
  IHMprincipale.titre();
  await IHMprincipale.menu();
  IHMprincipale.quitter();
}
