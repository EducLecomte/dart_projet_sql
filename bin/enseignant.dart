class Enseignant {
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
}
