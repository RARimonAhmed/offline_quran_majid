import 'dart:convert';

import 'package:surah_list_show_offline/database/quran_database.dart';
import 'package:surah_list_show_offline/models/surah_details_model.dart';
import 'package:surah_list_show_offline/models/surah_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  List<SurahListModel> surahList = <SurahListModel>[];
  List<Ayahs> surahsDetails = <Ayahs>[];
  Future<List<SurahListModel>> surahsList() async {
    var url = 'https://api.alquran.cloud/v1/surah';
  Response response = await http.get(Uri.parse(url));

    if(surahList.isEmpty){
      // await db.execute('DELETE FROM surahs WHERE number BETWEEN 1 AND 114');

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
    }else {
      print("suralist has data");
      return surahList;
    }

  }

  late String apiUrl;
  dynamic surahDetails;
  Future<void> fetchSurahDetails(int surahIndex) async {
    apiUrl = "https://api.alquran.cloud/v1/surah/$surahIndex/uthmani";
    final response = await http.get(Uri.parse(apiUrl));
    final jsonData = json.decode(response.body);
    surahDetails = jsonData["data"];
  }
  // Future<List<Ayahs>> getSurahDetails() async {
  //   var surahDetailsUrl = 'https://api.alquran.cloud/v1/quran/quran-uthmani';
  //   Response response = await http.get(Uri.parse(surahDetailsUrl));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> json = jsonDecode(response.body.toString());
  //     var suraJsonArr = json["data"]["surahs"];
  //     for (var ayath in suraJsonArr) {
  //       if (surahList.length < 114) {
  //         Ayahs ayahs = Ayahs(
  //             number: ayath['number'],
  //             text: ayath['text'],
  //             numberInSurah: ayath['numberInSurah'],
  //             juz: ayath['juz'],
  //             manzil: ayath['manzil'],
  //             page: ayath['page'],
  //             ruku: ayath['ruku'],
  //             hizbQuarter: ayath['hizbQuarter'],
  //             sajda: ayath['sajda']);
  //         surahsDetails.add(ayahs);
  //       }
  //     }
  //     var a_ayath;
  //     for (int i = 0; i < surahsDetails.length; i++) {
  //       a_ayath = surahsDetails[i];
  //     }

  //     print(a_ayath);
  //     print(a_ayath[0].text);

  //     var surah = a_ayath.map((i) => Ayahs.fromJson(<String, dynamic>{}));
  //     var maps;
  //     for (int i = 0; i < surah; i++) {
  //       maps = surah[i];
  //       Ayahs.fromJson(maps);
  //       // var sura = SurahListModel.fromJson();
  //       // await SurahListDb.instance.insertSurah(maps);
  //     }
  //     print(maps);
  //     return maps;
  //   } else {
  //     return surahsDetails;
  //   }
  // }
}
