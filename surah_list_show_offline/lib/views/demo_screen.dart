// import 'package:flutter/material.dart';
// import 'package:surah_list_show_offline/api_services/test.dart';

// class DemoScreen extends StatefulWidget {
//   const DemoScreen({super.key});

//   @override
//   State<DemoScreen> createState() => _DemoScreenState();
// }

// class _DemoScreenState extends State<DemoScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Demo Screen"),
//       ),
//       body: FutureBuilder(
//           future: DemoService.fetchData(),
//           builder: (context, AsyncSnapshot snapshot) {
//             print(snapshot.hasData);
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: ((context, index) {
//                 print(snapshot.data![index]!.data.ayahs[index].text);
//                 return ListTile(
//                   title: Text(snapshot.data![index]!.data.ayahs[index].text),
//                   subtitle: Text(snapshot
//                       .data![index]!.data.ayahs[index].numberInSurah
//                       .toString()),
//                   trailing: Text(snapshot.data![index]!.data.ayahs[index].number
//                       .toString()),
//                 );
//               }),
//             );
//           }),
//     );
//   }
// }
