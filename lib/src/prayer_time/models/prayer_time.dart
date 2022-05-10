import 'package:equatable/equatable.dart';

class PrayerTime extends Equatable {
  DateTime? shubuh;
  DateTime? sunrise;
  DateTime? dhuhur;
  DateTime? ashar;
  DateTime? maghrib;
  DateTime? isya;
  DateTime? middleOfTheNight;
  DateTime? lastThirdOfTheNight;

  PrayerTime({
    this.shubuh,
    this.sunrise,
    this.dhuhur,
    this.ashar,
    this.maghrib,
    this.isya,
    this.middleOfTheNight,
    this.lastThirdOfTheNight,
  });

  @override
  List<Object?> get props => [
        shubuh,
        sunrise,
        dhuhur,
        ashar,
        maghrib,
        isya,
        middleOfTheNight,
        lastThirdOfTheNight,
      ];
}

