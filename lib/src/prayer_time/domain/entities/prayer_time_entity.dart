import 'package:equatable/equatable.dart';

class PrayerTime extends Equatable {
  final String? shubuh;
  final String? dhuhur;
  final String? ashar;
  final String? maghrib;
  final String? isya;

  PrayerTime({this.shubuh, this.dhuhur, this.ashar, this.maghrib, this.isya});

  @override
  List<Object?> get props => [
        shubuh,
        dhuhur,
        ashar,
        maghrib,
        isya,
      ];
}
