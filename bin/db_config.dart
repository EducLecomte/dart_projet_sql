import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import 'etudiant.dart';

class DBConfig {
  // permet la création des tables, en vérifiant si elles existes ou non
  // et créé les tables manquantes si besoin
  static Future<void> createTables(ConnectionSettings settings) async {
    bool checkEtudiant = false;
    bool checkEnseignant = false;

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Etudiants") {
              checkEtudiant = true;
            }
            if (fields.toString() == "Enseignant") {
              checkEnseignant = true;
            }
          }
        }
        if (!checkEtudiant) {
          requete = 'CREATE TABLE Etudiants (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), email varchar(255), age int);';
          await conn.query(requete);
        }
        if (!checkEnseignant) {
          requete = 'CREATE TABLE Enseignants (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255));';
          await conn.query(requete);
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // retourne vrai si toute les tables sont créé, faux sinon
  static Future<bool> checkTables(ConnectionSettings settings) async {
    bool checkAll = false;
    bool checkEtudiant = false;
    bool checkEnseignant = false;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      String requete = "SHOW TABLES;";
      try {
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Etudiants") {
              checkEtudiant = true;
            }
            if (fields.toString() == "Enseignants") {
              checkEnseignant = true;
            }
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }

    if (checkEtudiant && checkEnseignant) {
      checkAll = true;
    }
    return checkAll;
  }

  // retourne la liste des noms des tables dans la BDD;
  static Future<List<String>> selectTables(ConnectionSettings settings) async {
    List<String> listTable = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            listTable.add(fields);
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
    return listTable;
  }

  // permet de supprimer une table via son nom passé en parametre, si elle existe dans la database
  static Future<void> dropTable(ConnectionSettings settings, String table) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        await conn.query("DROP TABLES IF EXISTS " + table + ";");
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // supprime toute les tables dans la DB
  static Future<void> dropAllTable(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            await conn.query("DROP TABLES IF EXISTS " + fields + ";");
          }
        }
      } catch (e) {
        log(e.toString());
      }

      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<dynamic> executerRequete(ConnectionSettings settings, String requete) async {
    Results? reponse;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        reponse = await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return reponse;
  }
}
