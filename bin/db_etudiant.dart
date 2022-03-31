import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import 'db_config.dart';
import 'etudiant.dart';

class DBEtudiant {
  static Future<Etudiant> selectEtudiant(ConnectionSettings settings, int id) async {
    Etudiant etu = Etudiant.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Etudiants WHERE id=" + id.toString() + " AND EXISTS (SELECT id FROM Etudiants WHERE id=" + id.toString() + " );";
        Results reponse = await conn.query(requete);
        etu = Etudiant(reponse.first['id'], reponse.first['name'], reponse.first['email'], reponse.first['age']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return etu;
  }

  static Future<List<Etudiant>> selectAllEtudiants(ConnectionSettings settings) async {
    List<Etudiant> listeEtu = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Etudiants;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Etudiant etu = Etudiant(row['id'], row['name'], row['email'], row['age']);
          listeEtu.add(etu);

          /*
          // variante avec création d'étudiant depuis une liste
          List<String> unEtu = [];
          for (var field in row) {
            unEtu.add(field.toString());
          }
          listeEtu.add(Etudiant.fromListString(unEtu));
          */
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeEtu;
  }

  static Future<void> insertEtudiant(ConnectionSettings settings, String nom, String email, int age) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "INSERT INTO Etudiants (name, email, age) VALUES('" + nom + "', '" + email + "', '" + age.toString() + "');";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //update
  static Future<void> updateEtudiant(ConnectionSettings settings, int id, String nom, String email, int age) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "UPDATE Etudiants SET nom = '" + nom + ", email = '" + email + ", age = '" + age.toString() + ", ' WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //delete
  static Future<void> deleteEtudiant(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "DELETE FROM Etudiants WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //delete all
  static Future<void> deleteAllEtudiant(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "TRUNCATE TABLE Etudiants;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un etudiant selon son ID
  static Future<bool> exist(ConnectionSettings settings, int id) async {
    bool exist = false;
    if (!(await DBEtudiant.selectEtudiant(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getEtudiant
  static Future<Etudiant> getEtudiant(ConnectionSettings settings, int id) async {
    dynamic r = await selectEtudiant(settings, id);
    ResultRow rr = r.first;
    return Etudiant(rr['id'], rr['nom'], rr['email'], rr['age']);
  }
}
