import 'package:mysql1/mysql1.dart';

import 'db_config.dart';
import 'etudiant.dart';

class DBEtudiant {
  static Future<Etudiant> selectEtudiant(int id) async {
    Etudiant etu = Etudiant.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Etudiants WHERE id=" + id.toString() + " AND EXISTS (SELECT id FROM Etudiants WHERE id=" + id.toString() + " );";
        Results reponse = await conn.query(requete);
        etu = Etudiant(reponse.first['id'], reponse.first['name'], reponse.first['email'], reponse.first['age']);
      } catch (e) {
        print(e);
      }
      conn.close();
    } catch (e) {
      print(e);
    }

    return etu;
  }

  static Future<void> insertEtudiant(String nom, String email, int age) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "INSERT INTO Etudiants (name, email, age) VALUES('" + nom + "', '" + email + "', '" + age.toString() + "');";
        await conn.query(requete);
      } catch (e) {
        print(e);
      }
      conn.close();
    } catch (e) {
      print(e);
    }
  }

  //update
  static Future<void> updateEtudiant(int id, String nom, String email, int age) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "UPDATE Etudiants SET nom = '" + nom + ", email = '" + email + ", age = '" + age.toString() + ", ' WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        print(e);
      }
      conn.close();
    } catch (e) {
      print(e);
    }
  }

  //delete
  static Future<void> deleteEtudiant(int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "DELETE FROM Etudiants WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        print(e);
      }
      conn.close();
    } catch (e) {
      print(e);
    }
  }

  // getEtudiant
  static Future<Etudiant> getEtudiant(int id) async {
    dynamic r = await selectEtudiant(id);
    ResultRow rr = r.first;
    return Etudiant(rr['id'], rr['nom'], rr['email'], rr['age']);
  }
}
