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
  void resetVerses() {
    _verses.clear();
    log("${_verses.length}");
  }

  final _audioUrl = <String>[].obs;
  List<String> get audioUrl => _audioUrl();

  var isLoading = false.obs;
  var showTafsir = false.obs;
  var isSave = false.obs;

  final _recenly = Surah().obs;
  Surah get recenlySurah => _recenly();
  void setRecenlySurah(Surah value) {
    _recenly.value = value;
  }

  Future fetchListOfSurah() async {
    try {
      final url = Uri.parse("https://api.quran.sutanlab.id/surah");
      isLoading.value = true;
      final response = await http.get(url);

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

        log(_listOfSurah.length.toString());

        return true;
      } else {
        log("Opps.. an error occured");
        return false;
      }
    } catch (e) {
      // throw ServerException();
      log(e.toString());
    }
  }

  Future<bool> fetchSurahByID(int? id) async {
    final url = Uri.parse("https://api.quran.sutanlab.id/surah/$id");
    // isLoading.value = true;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var verses = map['data']['verses'];
      for (var json in (verses as List)) {
        var verse = Verse.fromJson(json);
        _verses.add(verse);
        // if (_verses.isNotEmpty) {
        // isLoading.value = false;
        // }
        if (_listOfSurah.length < 2) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
        _audioUrl.add(verse.audio!.primary ?? "");
      }

      log(_verses.length.toString());
      log("audios = ${_audioUrl.length}");
      return true;
    } else {
      // isLoading.value = false;
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchListOfSurah();
  }
}
