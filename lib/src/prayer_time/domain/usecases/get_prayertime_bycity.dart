import 'package:dartz/dartz.dart';
import 'package:quran_app/helper/exception.dart';
import 'package:quran_app/src/prayer_time/domain/entities/prayer_time_entity.dart';
import 'package:quran_app/src/prayer_time/domain/repositories/prayer_time_repository.dart';

class GetPrayerTimeByCity {
  final PrayerTimeRepository repository;

  GetPrayerTimeByCity(this.repository);

  Future<Either<Failure, PrayerTime>> execute({required String city}) async {
    return await repository.getPrayerTimeByCity(city);
  }
}
