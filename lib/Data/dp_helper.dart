import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
class DbTables{
  static const String anime = "Anime";
  static const String classifications = "Classifications";
  static const String animeClassifications = "Anime_Classifications";
  static const String users = "Users";
}
String _animeTbl = 'CREATE TABLE ${DbTables.anime} (anime_id INTEGER PRIMARY KEY AUTOINCREMENT, anime_name TEXT, anime_details TEXT ,'
    'anime_image TEXT, anime_episodes INTEGER NULL, anime_type TEXT ,anime_status TEXT, anime_age TEXT, anime_studio TEXT NULL, '
    'release_date TEXT NULL, finish_date TEXT NULL, anime_rating REAL NULL, anime_genre TEXT, anime_season TEXT)';
String _userTbl = 'CREATE TABLE ${DbTables.users} (userId INTEGER PRIMARY KEY AUTOINCREMENT, '
    'userName TEXT , userPassword TEXT, userEmail TEXT, userImage TEXT NULL)';

// String _classificationsTbl = 'CREATE TABLE ${DbTables.classifications} (classification_id INTEGER PRIMARY KEY AUTOINCREMENT, '
//     'classification_name TEXT)';
//
// String _animeClassificationsTbl = 'CREATE TABLE ${DbTables.animeClassifications} (anime_classifications_id INTEGER PRIMARY KEY, '
//     'anime_id INTEGER, classification_id INTEGER, FOREIGN KEY (anime_id) REFERENCES anime(anime_id),'
//     'FOREIGN KEY (classification_id) REFERENCES classifications(classification_id))';

class DbHelper{
  static DbHelper? dbHelper;
  static Database? _database;
  DbHelper._createInstance(); //constructor...

  factory DbHelper(){
    dbHelper ??= DbHelper._createInstance();// checks if dbHelper is null(??),if so, will crate new opj.
    return dbHelper as DbHelper;
  }

  Future<Database> _initializeDatabase() async {
    int dbVersion =1;
    // var path = getDatabasesPath(); //this is another way to get to the path of the database
    final dbFolder = await getExternalStorageDirectory(); //this is saved in Android/data .. in phone's file.
    final dbPath = p.join(dbFolder!.path, "Databases"); //join two paths external storage and the DataBases folder
    Directory dbFolderDir = await Directory(dbPath).create(recursive: true);// if directory does not exist, will create one,
                                                                      //recursive is true in case it was folder inside folder ...
    final file = File(p.join(dbFolderDir.path, 'otakulife.db'));
    var testDb = await openDatabase(
        file.path,
        version: dbVersion,
        onCreate: _createDatabaseV1,
        onDowngrade: onDatabaseDowngradeDelete//if we update the version, it will delete the old one.
    );
    return testDb;
  }

  void _createDatabaseV1(Database db, int version) async {
    try {
      await db.execute(_animeTbl);
      await db.execute(_userTbl);
      // await db.execute(_classificationsTbl);
      // await db.execute(_animeClassificationsTbl);
    }
    catch(e){
      rethrow;
    }
  }

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database as Database;
  }


  Future<List<Map<String, dynamic>>?> getAll(String tbl) async{
    try {
      Database db = await database;
      var res = await db.query(tbl);
      return res;
    } on Exception {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getById(String tableName, int id, {String pkName = "anime_id"}) async{
    try {
      Database db = await database;
      var result= await db.query(tableName,where: "$pkName = ?", whereArgs: [id]);
      return result.isNotEmpty ? result.first : null;
    } on Exception {
      return null;
    }
  }
  Future<List<Map<String, dynamic>>> getByName(String tableName, String name,
      {String pkName = "anime_id"}) async {
    try {
      Database db = await database;
      var result = await db.query(tableName,
          where: "LOWER(anime_name) LIKE ?",
          whereArgs: ['%$name%']);
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getUserById(String tableName, int id, {String pkName = "userId"}) async{
    try {
      Database db = await database;
      var result= await db.query(tableName,where: "$pkName = ?", whereArgs: [id]);
      return result.isNotEmpty ? result.first : null;
    } on Exception {
      return null;
    }

  }

  Future<int> add(String tbl, Map<String, dynamic> obj)async{
    try {
      Database db = await database;
      var res = await db.insert(tbl, obj, conflictAlgorithm: ConflictAlgorithm.ignore );
      return res;
    } on Exception {
      return 0;
    }
  }


  Future<int> updateAnimeClass(String tbl, Map<String, dynamic> obj, {String pkName = 'anime_classifications_id'})async{
    try {
      Database db = await database;
      var pkValue = obj[pkName];
      if(pkValue != null){
        var res = await db.update(tbl, obj, where: '$pkName = ?', whereArgs: [pkValue], conflictAlgorithm: ConflictAlgorithm.ignore);
        return res;
      }
      return 0;
    } on Exception {
      return 0;
    }
  }


  Future<int> update(String tbl, Map<String, dynamic> obj, {String pkName = 'classification_id'})async{
    try {
      Database db = await database;
      var pkValue = obj[pkName];
      if(pkValue != null){
        var res = await db.update(tbl, obj, where: '$pkName = ?', whereArgs: [pkValue], conflictAlgorithm: ConflictAlgorithm.ignore);
        return res;
      }
      return 0;
    } on Exception {
      return 0;
    }
  }

  Future<int> updateUser(String tbl, Map<String, dynamic> obj, {String pkName = 'userId'})async{
    try {
      Database db = await database;
      var pkValue = obj[pkName];
      if(pkValue != null){
        var res = await db.update(tbl, obj, where: '$pkName = ?', whereArgs: [pkValue], conflictAlgorithm: ConflictAlgorithm.ignore);
        return res;
      }
      return 0;
    } on Exception {
      return 0;
    }
  }

  Future<int> delete(String tbl,Object pkValue, {String pkName = 'classification_id'})async{
    try {
      Database db = await database;
      var res = await db.delete(tbl, where: '$pkName = ?', whereArgs: [pkValue]);
      return res;
    } on Exception {
      return 0;
    }
  }
  Future<int> deleteUser(String tbl,Object pkValue, {String pkName = 'userId'})async{
    try {
      Database db = await database;
      var res = await db.delete(tbl, where: '$pkName = ?', whereArgs: [pkValue]);
      return res;
    } on Exception {
      return 0;
    }
  }


  Future<int> updateanime(String tbl, Map<String, dynamic> obj, {String pkName = 'anime_id'})async{
    try {
      Database db = await database;
      var pkValue = obj[pkName];
      if(pkValue != null){
        var res = await db.update(tbl, obj, where: '$pkName = ?', whereArgs: [pkValue], conflictAlgorithm: ConflictAlgorithm.ignore);
        return res;
      }
      return 0;
    } on Exception {
      return 0;
    }
  }

  Future<int> deleteanime(String tbl,Object pkValue, {String pkName = 'anime_id'})async{
    try {
      Database db = await database;
      var res = await db.delete(tbl, where: '$pkName = ?', whereArgs: [pkValue]);
      return res;
    } on Exception {
      return 0;
    }
  }

  // Future<List<Map<String, dynamic>>?> getClassificationsForAnime(String tbl, int animeId) async {
  //   try {
  //     Database db = await database;
  //     var res = await db.rawQuery('''
  //     SELECT ${DbTables.classifications}.classification_id, ${DbTables.Classifications}.classification_name
  //     FROM ${DbTables.anime_classifications}
  //     INNER JOIN ${DbTables.classifications} ON ${DbTables.Anime_Classifications}.classification_id = ${DbTables.Classifications}.classification_id
  //     WHERE ${DbTables.Anime_Classifications}.anime_id = ?
  //   ''', [animeId]);
  //     return res;
  //   } catch (e) {
  //     print("Exception in getClassificationsForAnime: $e");
  //     return null;
  //   }
  // }

  // Future<int> addClassificationsToAnime(String tbl, Map<String, dynamic> animeObj, List<Map<String, dynamic>> classificationsObjs) async {
  //   try {
  //     Database db = await database;
  //
  //     // Insert the student record
  //     var animeRes = await db.insert(tbl, animeObj, conflictAlgorithm: ConflictAlgorithm.ignore);
  //
  //     // Insert the course records
  //     for (var classificationsObj in classificationsObjs) {
  //       var classificationsRes = await db.insert(tbl, classificationsObj, conflictAlgorithm: ConflictAlgorithm.ignore);
  //     }
  //
  //     return animeRes;
  //   } catch (e) {
  //     print("EXP in Insert: $e");
  //     return 0;
  //   }
  // }


}