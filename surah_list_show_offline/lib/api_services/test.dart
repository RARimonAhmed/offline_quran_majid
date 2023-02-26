import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surah_list_show_offline/models/surah_model.dart';

class DemoService {
  // static Future<SurahDetailsModel?> fetchData() async {
  //   final response = await http
  //       .get(Uri.parse("https://api.alquran.cloud/v1/surah/1/uthmani"));
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     return surahDetailsModelFromJson(data);
  //   } else {
  //     return null;
  //   }
  // }

  // static Future<List<SurahDetailsModel?>> fetchData() async {
  //   final response = await http
  //       .get(Uri.parse('https://api.alquran.cloud/v1/surah/1/uthmani'));
  //   //print(response.body.toString());
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     return data.map((json) => SurahDetailsModel.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to fetch books');
  //   }
  // }
}
