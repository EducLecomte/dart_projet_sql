import 'package:mysql1/mysql1.dart';

import 'ihm_principale.dart';

void main(List<String> arguments) async {
  IHMprincipale.titre();
  ConnectionSettings settings = IHMprincipale.setting();
  await IHMprincipale.menu();
  IHMprincipale.quitter();
}
