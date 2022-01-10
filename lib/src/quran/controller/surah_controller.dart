import 'dart:convert';
import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/src/quran/model/surah.dart';
import 'package:quran_app/src/quran/model/verse.dart';

class SurahController extends GetxController {
  final _listOfSurah = <Surah>[].obs;
  List<Surah> get listOfSurah => _listOfSurah();

  final _verses = <Verse>[].obs;
  List<Verse> get verses => _verses();

  var isLoading = true.obs;
  var showTafsir = false.obs;

  Future fetchListOfSurah() async {
    final url = Uri.parse("https://api.quran.sutanlab.id/surah");
    final response = await http.get(url);

    isLoading.value = true;

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var data = map['data'];
      for (var json in (data as List)) {
        var surah = Surah.fromJson(json);
        _listOfSurah.add(surah);
        if (_listOfSurah.isNotEmpty) {
          isLoading.value = false;
        }
        if (_listOfSurah.length < 9) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }

      print(_listOfSurah.length);

      return true;
    } else {
      log("Opps.. an error occured");
    }
  }

  Future fetchSurahByID(int? id) async {
    final url = Uri.parse("https://api.quran.sutanlab.id/surah/$id");
    final response = await http.get(url);

    isLoading.value = true;

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var verses = map['data']['verses'];
      for (var json in (verses as List)) {
        var verse = Verse.fromJson(json);
        _verses.add(verse);
        if (_verses.isNotEmpty) {
          isLoading.value = false;
        }
        if (_listOfSurah.length < 7) {
          await Future.delayed(const Duration(milliseconds: 1000));
        }
      }

      print(_verses.length);
      return true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchListOfSurah();
  }
}
