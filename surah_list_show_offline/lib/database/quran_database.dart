import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:surah_list_show_offline/models/surah_details_model.dart';
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

    await db.execute("""
          CREATE TABLE ayah_details (
            surah_id INTEGER AUTO INCREMENT PRIMARY KEY ,
            number INTEGER ,
            text TEXT ,
            numberInSurah INTEGER ,
            juz INTEGER ,
            manzil INTEGER ,
            page INTEGER ,
            ruku  INTEGER ,
            hizbQuarter INTEGER ,
            sajda TEXT
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
    return db.query(
      "surahs",
      orderBy: "number",
    );
  }

  Future<List<Ayahs?>> insertAyahDetails(List<Ayahs?> ayah) async {
    print("insert surah details method is called");
    final db = await instance.database;
    List<int> ids = [];
    for (var ayahs in ayah) {
      final id = await db.insert('ayah_details', ayahs!.toJson());
      ids.add(id);
    }
    print("Data is inserted");
    return ayah;
  }

  // Future<List<Map<String, dynamic>>> ayathList =
  //     [] as Future<List<Map<String, dynamic>>>;
  var data;
  Future<List<Map<String, dynamic>>> getAyahOfSurah(int index) async {
    final db = await SurahListDb.instance.database;
    data = db
        .query("ayah_details",
            where: "numberInSurah == $index", orderBy: "number")
        .toString();
    print("Data is $data");

    return data;
  }
}
