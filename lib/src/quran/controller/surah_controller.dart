import 'dart:convert';
import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/src/quran/model/surah.dart';

class SurahController extends GetxController {
  final _listOfSurah = <Surah>[].obs;
  List<Surah> get listOfSurah => _listOfSurah();

  fetchListOfSurah() async {
    final url = Uri.parse("https://api.quran.sutanlab.id/surah");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var data = map['data'];
      for (var json in (data as List)) {
        var surah = Surah.fromJson(json);
        _listOfSurah.add(surah);
      }

      print(_listOfSurah.length);

      return true;
    } else {
      log("Opps.. an error occured");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchListOfSurah();
  }
}
