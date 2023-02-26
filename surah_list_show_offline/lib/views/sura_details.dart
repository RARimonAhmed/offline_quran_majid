import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surah_list_show_offline/api_services/api_services.dart';
import 'package:surah_list_show_offline/database/quran_database.dart';

class SurahDetailsPage extends StatelessWidget {
  final int surahIndex;

  const SurahDetailsPage({super.key, required this.surahIndex});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    apiService.fetchAyahDetails(surahIndex);
    SurahListDb surahListDb = SurahListDb.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah Details'),
      ),
      body: FutureBuilder(
          future: surahListDb.getAyahOfSurah(surahIndex),
          builder: ((context, snapshot) {
            if (surahListDb.data == null) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    surahListDb.getAyahOfSurah(surahIndex);
                    return ListTile(
                      leading: Text(surahListDb.data[surahIndex]),
                      title: Text(snapshot.data.toString()),
                    );
                  });
            }
          })),
      //  apiService.surahDetails == null
      //     ? const Center(child: CircularProgressIndicator())
      //     :
    );
  }
}
// ListView(
//               padding: const EdgeInsets.all(16.0),
//               children: <Widget>[
//                 Text(
//                   "Surah Number: ${apiService.surahDetails["number"]}",
//                   style: const TextStyle(fontSize: 20.0),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Text(
//                   "Surah Name: ${apiService.surahDetails["name"]}",
//                   style: const TextStyle(fontSize: 20.0),
//                 ),
//                 const SizedBox(height: 16.0),
//                 Text(
//                   "Number of Verses: ${apiService.surahDetails["numberOfAyahs"]}",
//                   style: const TextStyle(fontSize: 20.0),
//                 ),
//                 const SizedBox(height: 32.0),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const ClampingScrollPhysics(),
//                   itemCount: apiService.surahDetails["ayahs"].length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       title: Text(
//                         apiService.surahDetails["ayahs"][index]["text"],
//                         textAlign: TextAlign.right,
//                         style: const TextStyle(fontSize: 24.0),
//                       ),
//                       subtitle: Text(
//                         "Verse ${apiService.surahDetails["ayahs"][index]["numberInSurah"]}",
//                         textAlign: TextAlign.right,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
