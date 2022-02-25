import 'dart:convert';

import 'package:quran_app/src/helper/exception.dart';
import 'package:quran_app/src/quran/model/surah.dart';
import 'package:http/http.dart' as http;

abstract class QuranRepository {
  Future<Surah> fetchSurahByID(int id);
  Future<List<Surah>> fetchListOfSurah();
}

class QuranRepositoryImpl implements QuranRepository {
  @override
  Future<Surah> fetchSurahByID(int id) {
    // TODO: implement fetchSurahByID
    throw UnimplementedError();
  }

  @override
  Future<List<Surah>> fetchListOfSurah() async {
    final url = Uri.parse("https://api.quran.sutanlab.id/surah");
    final response = await http.get(url);

    List<Surah> listOfSurah = [];

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var data = map['data'];
      for (var json in (data as List)) {
        var surah = Surah.fromJson(json);
        listOfSurah.add(surah);
        await Future.delayed(const Duration(milliseconds: 500));
      }
      return listOfSurah;
    } else {
      throw ServerException();
    }
  }
}