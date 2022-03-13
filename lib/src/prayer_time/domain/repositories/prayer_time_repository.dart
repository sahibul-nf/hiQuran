import 'package:dartz/dartz.dart';
import 'package:quran_app/helper/exception.dart';
import 'package:quran_app/src/prayer_time/domain/entities/prayer_time_entity.dart';

abstract class PrayerTimeRepository {
  Future<Either<Failure, PrayerTime>> getPrayerTimeByCity(String city);
}
