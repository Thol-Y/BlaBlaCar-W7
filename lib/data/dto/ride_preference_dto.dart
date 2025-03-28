import '../../model/ride/ride_pref.dart';
import '../../model/location/location.dart';
import 'location_dto.dart';

class RidePreferenceDto {
  final Location from;
  final Location to;
  final DateTime date;
  final int passengers;

  RidePreferenceDto({
    required this.from,
    required this.to,
    required this.date,
    required this.passengers,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': LocationDto.fromModel(from).toJson(),
      'to': LocationDto.fromModel(to).toJson(),
      'date': date.toIso8601String(),
      'passengers': passengers,
    };
  }

  factory RidePreferenceDto.fromJson(Map<String, dynamic> json) {
    return RidePreferenceDto(
      from:
          LocationDto.fromJson(json['from'] as Map<String, dynamic>).toModel(),
      to: LocationDto.fromJson(json['to'] as Map<String, dynamic>).toModel(),
      date: DateTime.parse(json['date'] as String),
      passengers: json['passengers'] as int,
    );
  }

  factory RidePreferenceDto.fromModel(RidePreference model) {
    return RidePreferenceDto(
      from: model.departure,
      to: model.arrival,
      date: model.departureDate,
      passengers: model.requestedSeats,
    );
  }

  RidePreference toModel() {
    return RidePreference(
      departure: from,
      arrival: to,
      departureDate: date,
      requestedSeats: passengers,
    );
  }
}
