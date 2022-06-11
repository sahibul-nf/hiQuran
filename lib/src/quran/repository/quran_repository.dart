// import 'dart:convert';
// import 'package:quran_app/src/quran/model/surah.dart';
// import 'package:http/http.dart' as http;

// abstract class QuranRepository {
//   Future<Surah> getSurahByID(int id);
//   // Future<List<Surah>> getListOfSurah();
// }

// class QuranRepositoryImpl implements QuranRepository {
//   @override
//   Future<Surah> getSurahByID(int id) async {
//     final url = Uri.parse("https://hiquran-api.herokuapp.com/surah/$id");
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       var map = jsonDecode(response.body);
//       var verses = map['data']['verses'];
//       for (var json in (verses as List)) {
//         var verse = Verse.fromJson(json);
//         _verses.add(verse);
//       }

//       return Surah();
//     } else {}
//   }

//   // @override
//   // Future<List<Surah>> fetchListOfSurah() async {
//   //   final url = Uri.parse("https://hiquran-api.herokuapp.com/surah");
//   //   final response = await http.get(url);

//   //   List<Surah> listOfSurah = [];

//   //   if (response.statusCode == 200) {
//   //     var map = jsonDecode(response.body);
//   //     var data = map['data'];
//   //     for (var json in (data as List)) {
//   //       var surah = Surah.fromJson(json);
//   //       listOfSurah.add(surah);
//   //       await Future.delayed(const Duration(milliseconds: 500));
//   //     }
//   //     return listOfSurah;
//   //   } else {
//   //     return [];
//   //   }
//   // }
// }
