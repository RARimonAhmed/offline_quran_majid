import 'package:surah_list_show_offline/api_services/api_services.dart';
import 'package:surah_list_show_offline/database/quran_database.dart';

class HomePageController {
  List<Map<String, dynamic>> suraList = [];
  bool isLoading = true;
  dynamic counter;
  ApiService apiService = ApiService();
  refreshData() async {
    print("counter = $counter");
    if (counter == 0) {
      counter++;
      apiService.surahsList();
      print("from if block counter = $counter");
      // final suraData = await SurahListDb.instance.getSurah();
      // suraList = suraData;
      // isLoading = false;
    } else {
      counter++;
      print("from if else counter = $counter");
      final suraData = await SurahListDb.instance.getSurah();
      suraList = suraData;
      isLoading = false;
    }
    counter++;
  }
}
