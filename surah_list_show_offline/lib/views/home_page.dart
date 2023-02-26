import 'package:flutter/material.dart';
import 'package:surah_list_show_offline/controllers/data_controller.dart';
import 'package:surah_list_show_offline/views/sura_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController homePageController = HomePageController();

  @override
  void initState() {
    super.initState();
    homePageController.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      homePageController.refreshData();
    }

    return FutureBuilder(
        future: homePageController.refreshData(),
        builder: ((context, snapshot) {
          if (homePageController.suraList.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: homePageController.suraList.length,
                itemBuilder: ((context, index) {
                  print(homePageController.suraList.length);
                  return Card(
                    child: ListTile(
                      leading: Text(homePageController.suraList[index]['number']
                          .toString()),
                      title: Text(homePageController.suraList[index]['name']),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SurahDetailsPage(
                                      surahIndex: index + 1,
                                    ))));
                      },
                    ),
                  );
                }));
          }
        }));
  }
}
