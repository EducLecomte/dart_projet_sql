import 'data.dart';

class Enseignant implements Data {
  int _id = 0;
  String _nom = "";

  Enseignant(this._id, this._nom);
  Enseignant.sansID(this._nom);
  Enseignant.vide();

  int getId() {
    return this._id;
  }

  String getNom() {
    return this._nom;
  }

  @override
  String getEntete() {
    // TODO: implement getEntete
    throw UnimplementedError();
  }

  @override
  String getInLine() {
    // TODO: implement getInLine
    throw UnimplementedError();
  }
}
