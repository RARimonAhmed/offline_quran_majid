import 'dart:convert';

import 'package:surah_list_show_offline/database/quran_database.dart';
import 'package:surah_list_show_offline/models/surah_details_model.dart';
import 'package:surah_list_show_offline/models/surah_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  List<SurahListModel> surahList = <SurahListModel>[];
  List<Ayahs> ayahDetails = <Ayahs>[];
  Future<List<SurahListModel>> surahsList() async {
    var url = 'https://api.alquran.cloud/v1/surah';
    Response response = await http.get(Uri.parse(url));
    if (surahList.isEmpty) {
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        var suraJSONArr = json["data"];
        for (var singleSura in suraJSONArr) {
          if (surahList.length < 114) {
            SurahListModel surah = SurahListModel(
                number: singleSura['number'],
                name: singleSura['name'],
                englishName: singleSura['englishName'],
                englishNameTranslation: singleSura['englishNameTranslation'],
                numberOfAyahs: singleSura['numberOfAyahs'],
                revelationType: singleSura['revelationType']);
            surahList.add(surah);
          }
        }
        dynamic maps;
        dynamic surah =
            surahList.map((i) => SurahListModel.fromJson(<String, dynamic>{}));
        for (int i = 0; i < surahList.length; i++) {
          maps = surahList[i];
          await SurahListDb.instance.insertSurah(maps);
        }
        return surahList;
      } else {
        return surahList;
      }
    } else {
      return surahList;
    }
  }

  late String apiUrl;
  Future<List<Ayahs>> fetchAyahDetails(int surahIndex) async {
    print("fetch surah details method is called");
    apiUrl = "https://api.alquran.cloud/v1/surah/$surahIndex/uthmani";
    final response = await http.get(Uri.parse(apiUrl));
    final jsonData = json.decode(response.body.toString());
    var listOfAyah = jsonData["data"]["ayahs"] as List;
    List<Ayahs> produkte = listOfAyah
        .map((i) => Ayahs.fromJson(Map<String, dynamic>.from(i)))
        .toList();
    for (int i = 0; i < listOfAyah.length; i++) {
      var ayah = listOfAyah[i];
      print(ayah.toString());
      var ayahModel = Ayahs.fromJson(ayah);
      print(ayahModel);
      ayahDetails.add(ayahModel);
    }
    await SurahListDb.instance.insertAyahDetails(ayahDetails);
    return ayahDetails;
  }
}
