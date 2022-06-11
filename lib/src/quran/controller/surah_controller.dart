import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/src/quran/model/surah.dart';
import 'package:quran_app/src/quran/model/verse.dart';
import 'package:quran_app/src/quran/repository/surah_favorite_repository.dart';
import 'package:string_similarity/string_similarity.dart';

class SurahController extends GetxController {
  final _listOfSurah = <Surah>{}.obs;
  Set<Surah> get listOfSurah => _listOfSurah();

  final _listOfSearchedSurah = <Surah>{}.obs;
  Set<Surah> get listOfSerchedSurah => _listOfSearchedSurah().obs;
  void resetListOfSearchedSurah() {
    _listOfSearchedSurah.clear();
  }

  searchSurah(String query) {
    // _listOfSearchedSurah.clear();

    if (query.isEmpty) {
      _listOfSearchedSurah.clear();
    } else {
      for (var item in _listOfSurah) {
        double similiarity = query.similarityTo(item.name?.id?.toLowerCase());
        String s = "${item.name?.id} = $similiarity";
        if (similiarity >= 0.7) {
          log(s);
          _listOfSearchedSurah.add(item);
        }
      }
    }
  }

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
    // clear list of surah
    _listOfSurah.clear();

    try {
      final url = Uri.parse("https://hiquran-api.herokuapp.com/surah");
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
          if (_listOfSurah.length < 3) {
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
    resetVerses();

    final url = Uri.parse("https://hiquran-api.herokuapp.com/surah/$id");
    // isLoading.value = true;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var verses = map['data']['verses'];
      for (var json in (verses as List)) {
        var verse = Verse.fromJson(json);
        _verses.add(verse);
        // isLoading.value = false;
        // if (_verses.length < 2) {
        //   await Future.delayed(const Duration(milliseconds: 200));
        // }
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

  // FAVORITE
  final _surahFavorites = <Surah>{}.obs;
  Set<Surah> get surahFavorites => _surahFavorites();

  var isFavoriteLoaded = false.obs;
  var isFavoriteDeleted = false.obs;

  bool isFavorite(Surah surah) {
    return _surahFavorites.contains(surah);
  }

  Future<bool> addToFavorite(int userID, Surah surah) async {
    final surahRepo = SurahFavoriteRepositoryImpl();

    final value = await surahRepo.addSurahFavorite(userID, surah.number!);
    if (value.error != null) {
      Get.snackbar("Opps", value.error.toString());
      return false;
    } else {
      if (value.surahFavorites!.isNotEmpty) {
        _surahFavorites.add(surah);
        printInfo(info: "add to favorite");
      }
      return true;
    }
  }

  Future<bool> removeFromFavorite(int userID, Surah surah) async {
    final surahRepo = SurahFavoriteRepositoryImpl();

    isFavoriteDeleted.value = true;

    final value = await surahRepo.removeSurahFavorite(userID, surah.number!);
    if (value.error != null) {
      Get.snackbar("Opps", value.error.toString());
      isFavoriteDeleted.value = false;
      return false;
    } else {
      if (value.surahFavorites!.isNotEmpty) {
        _surahFavorites.remove(surah);
        printInfo(info: "remove from favorite");
      }
      isFavoriteDeleted.value = false;
      return true;
    }
  }

  void removeAllFromFavorite(int userID) async {
    final surahRepo = SurahFavoriteRepositoryImpl();

    isFavoriteDeleted.value = true;

    final value = await surahRepo.removeAllSurahFavorite(userID);
    if (value.error != null) {
      Get.snackbar("Opps", value.error.toString());
    } else {
      if (value.surahFavorites!.isNotEmpty) {
        _surahFavorites.clear();
        printInfo(info: "remove all from favorite");
      }
      Get.back();
    }

    isFavoriteDeleted.value = false;
  }

  Future<void> fetchSurahFavorites(int userID) async {
    _surahFavorites.clear();

    final surahFavoriteRepo = SurahFavoriteRepositoryImpl();

    log(surahFavorites.length.toString());
    isFavoriteLoaded.value = true;

    final result = await surahFavoriteRepo.getListOfFavoriteSurah(userID);
    if (result.error != null) {
      Get.snackbar("Opps...", result.error.toString());
    } else {
      if (result.surahFavorites!.isNotEmpty) {
        var i = 0;
        do {
          for (var item in _listOfSurah) {
            if (item.number == result.surahFavorites![i].surahId) {
              _surahFavorites.add(item);
            }
          }

          i++;
        } while (i < result.surahFavorites!.length);
      }

      log(surahFavorites.length.toString());
    }

    isFavoriteLoaded.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchListOfSurah();
  }
}
