import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surah_list_show_offline/api_services/api_services.dart';

class SurahDetailsPage extends StatelessWidget {
  final int surahIndex;

  const SurahDetailsPage({required this.surahIndex});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah Details'),
      ),
      body: FutureBuilder(
          future: apiService.fetchSurahDetails(surahIndex),
          builder: ((context, snapshot) {
            if (apiService.surahDetails == null) {
              return const CircularProgressIndicator();
            } else {
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  Text(
                    "Surah Number: ${apiService.surahDetails["number"]}",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Surah Name: ${apiService.surahDetails["name"]}",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Number of Verses: ${apiService.surahDetails["numberOfAyahs"]}",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 32.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: apiService.surahDetails["ayahs"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          apiService.surahDetails["ayahs"][index]["text"],
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 24.0),
                        ),
                        subtitle: Text(
                          "Verse ${apiService.surahDetails["ayahs"][index]["numberInSurah"]}",
                          textAlign: TextAlign.right,
                        ),
                      );
                    },
                  ),
                ],
              );
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
