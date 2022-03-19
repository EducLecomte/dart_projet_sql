class Etudiant {
  int _id = 0;
  String _nom = "";
  String _email = "";
  int _age = 0;

  Etudiant(this._id, this._nom, this._email, this._age);
  Etudiant.sansID(this._nom, this._email, this._age);
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
}
