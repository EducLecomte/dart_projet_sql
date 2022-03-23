import 'data.dart';

class Etudiant implements Data {
  int _id = 0;
  String _nom = "";
  String _email = "";
  int _age = 0;

  Etudiant(this._id, this._nom, this._email, this._age);
  Etudiant.sansID(this._nom, this._email, this._age);
  Etudiant.fromListString(List<String> unEtu) {
    if (unEtu.length == 4) {
      this._id = int.parse(unEtu[0]);
      this._nom = unEtu[1];
      this._email = unEtu[2];
      this._id = int.parse(unEtu[3]);
    }
  }
  Etudiant.vide();

  int getId() {
    return this._id;
  }

  String getNom() {
    return this._nom;
  }

  String getEmail() {
    return this._email;
  }

  int getAge() {
    return this._age;
  }

  bool estNull() {
    bool estnull = false;
    if (_id == 0 && _nom == "" && _email == "" && _age == 0) {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEntete() {
    return "| id | name | email | age |";
  }

  @override
  String getInLine() {
    return "| " + _id.toString() + " | " + _nom + " | " + _email + " | " + _age.toString() + " |";
  }
}
