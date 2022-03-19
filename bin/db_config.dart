import 'package:mysql1/mysql1.dart';

import 'etudiant.dart';

class DBConfig {
  // attribut et méthode static, car pas besoin d'instanciation de la classe.
  static ConnectionSettings settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'DartUser',
    password: 'dartmdp',
    db: "DartDB",
  );

  static ConnectionSettings getSettings() {
    return settings;
  }

  // permet la création des tables, en vérifiant si elles existes ou non
  // et créé les tables manquantes si besoin
  static Future<void> createTables() async {
    bool checkEtudiant = false;
    bool checkEnseignant = false;

    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
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
  static Future<bool> checkTables() async {
    bool checkAll = false;
    bool checkEtudiant = false;
    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
      String requete = "SHOW TABLES;";
      try {
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Etudiants") {
              checkEtudiant = true;
            }
            // if(test pour une autre table) ...
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }

    if (checkEtudiant /*&& checkAutre ... */) {
      checkAll = true;
    }
    return checkAll;
  }

  // permet de supprimer une table via son nom passé en parametre, si elle existe dans la database
  static Future<void> dropTable(String table) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
      try {
        await conn.query("DROP TABLES IF EXISTS " + table + ";");
      } catch (e) {
        print(e);
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // supprime toute les tables dans la DB
  static Future<void> dropAllTable() async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            await conn.query("DROP TABLES IF EXISTS " + fields + ";");
          }
        }
      } catch (e) {
        print(e);
      }

      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<dynamic> executerRequete(String requete) async {
    Results? reponse;
    try {
      MySqlConnection conn = await MySqlConnection.connect(DBConfig.getSettings());
      try {
        reponse = await conn.query(requete);
      } catch (e) {
        print(e);
      }
      conn.close();
    } catch (e) {
      print(e);
    }
    return reponse;
  }
}
