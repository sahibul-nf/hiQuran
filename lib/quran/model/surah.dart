
class SurahEntity {
  int? number;
  int? sequence;
  String? tafsir;
  int? numberOfVerses;
  RevelationEntity? revelation;
  NameSurahEntity? name;

  SurahEntity({this.number, this.sequence, this.tafsir, this.numberOfVerses, this.name});

  factory SurahEntity.fromJson(Map<String, dynamic> json) {
    var surah = SurahEntity();
    surah.number = json['number'];
    surah.name = NameSurahEntity.fromJson(json['name']);
    surah.sequence = json['sequence'];
    surah.numberOfVerses = json['numberOfVerses'];
    surah.tafsir = json['tafsir']['id'];
    surah.revelation = RevelationEntity.fromJson(json['revelation']);
    return surah;
  }
}

class NameSurahEntity {
  String? arab;
  String? id;
  String? en;
  NameSurahEntity({this.arab, this.id, this.en});

  factory NameSurahEntity.fromJson(Map<String, dynamic> json) {
    return NameSurahEntity(
      arab: json['short'],
      en: json['transliteration']['en'],
      id: json['transliteration']['id'],
    );
  }
}

class RevelationEntity {
  String? arab;
  String? en;
  String? id;

  RevelationEntity({this.arab, this.id, this.en});

  factory RevelationEntity.fromJson(Map<String, dynamic> json) {
    return RevelationEntity(
      arab: json['arab'],
      en: json['en'],
      id: json['id'],
    );
  }
}
