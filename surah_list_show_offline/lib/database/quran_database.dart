import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:surah_list_show_offline/models/surah_list_model.dart';

class SurahListDb {
  static final SurahListDb instance = SurahListDb._init();
  static Database? _database;
  SurahListDb._init();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase("surah_list.db");
      return _database!;
    }
  }

  Future<Database> _initDatabase(String filePath) async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future _createTable(Database db, int version) async {
    await db.execute(" DROP TABLE IF EXISTS surahs ");
    await db.execute("""
          CREATE TABLE surahs (
            number INTEGER ,
            name TEXT ,
            englishName TEXT ,
            englishNameTranslation TEXT ,
            numberOfAyahs INTEGER ,
            revelationType TEXT 
          )
      """);
  }

  Future _createSurahDetailsTable(Database db, int version) async {
    await db.execute(" DROP TABLE IF EXISTS surahs_details ");
    await db.execute("""
          CREATE TABLE surahs_details (
            number INTEGER ,
            name TEXT ,
            englishName TEXT ,
            englishNameTranslation TEXT ,
            revelationType TEXT 
          )
      """);
  }

  Future<SurahListModel> insertSurah(SurahListModel? surahListModel) async {
    final db = await instance.database;

    final id = await db.insert("surahs", surahListModel!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return surahListModel;
  }

  Future<List<Map<String, dynamic>>> getSurah() async {
    final db = await SurahListDb.instance.database;
    return db.query("surahs", orderBy: "number");
  }

  Future<SurahListModel> insertSurahDetails(
      SurahListModel? surahListModel) async {
    final db = await instance.database;

    final id = await db.insert("surahs", surahListModel!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return surahListModel;
  }

  // Future<SurahListModel?> getSurah() async {
  //   final db = await instance.database;
  //   final maps = await db.query("surahs", orderBy: "number");
  //   if (maps.isNotEmpty) {
  //     return SurahListModel.fromJson(maps.first);
  //   } else {
  //     return null;
  //   }
  // }
}
