class Surah {
  int? number;
  int? sequence;
  String? tafsir;
  int? numberOfVerses;
  Revelation? revelation;
  NameSurah? name;

  Surah({
    this.number,
    this.sequence,
    this.tafsir,
    this.numberOfVerses,
    this.name,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    var surah = Surah();
    surah.number = json['number'];
    surah.name = NameSurah.fromJson(json['name']);
    surah.sequence = json['sequence'];
    surah.numberOfVerses = json['numberOfVerses'];
    surah.tafsir = json['tafsir']['id'];
    surah.revelation = Revelation.fromJson(json['revelation']);
    return surah;
  }
}

class NameSurah {
  String? arab;
  String? id;
  String? en;
  String? translationEn;
  String? translationId;
  NameSurah(
      {this.arab, this.id, this.en, this.translationEn, this.translationId});

  factory NameSurah.fromJson(Map<String, dynamic> json) {
    return NameSurah(
      arab: json['short'],
      en: json['transliteration']['en'],
      id: json['transliteration']['id'],
      translationEn: json['translation']['en'],
      translationId: json['translation']['id'],
    );
  }
}

class Revelation {
  String? arab;
  String? en;
  String? id;

  Revelation({this.arab, this.id, this.en});

  factory Revelation.fromJson(Map<String, dynamic> json) {
    return Revelation(
      arab: json['arab'],
      en: json['en'],
      id: json['id'],
    );
  }
}
