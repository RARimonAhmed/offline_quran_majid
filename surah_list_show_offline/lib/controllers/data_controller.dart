import 'package:surah_list_show_offline/api_services/api_services.dart';
import 'package:surah_list_show_offline/database/quran_database.dart';

class HomePageController {
  List<Map<String, dynamic>> suraList = [];
  bool isLoading = true;
  ApiService apiService = ApiService();
  refreshData() async {
    apiService.surahsList();
    // apiService.fetchAyahDetails();
    final suraData = await SurahListDb.instance.getSurah();
    suraList = suraData;
    isLoading = false;
  }
}
