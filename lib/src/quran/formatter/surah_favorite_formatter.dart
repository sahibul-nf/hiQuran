import 'package:quran_app/helper/result.dart';
import 'package:quran_app/src/quran/model/surah_favorite.dart';

class SurahFavoriteFormatter extends ResultFormatter {
  SurahFavoriteFormatter(String? error, this.surahFavorites) : super(error);

  final List<SurahFavorite>? surahFavorites;
}
