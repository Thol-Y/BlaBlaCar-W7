import '../../model/location/location.dart';

class LocationDto {
  final String name;
  final String address;

  LocationDto({
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
    };
  }

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      name: json['name'] as String,
      address: json['address'] as String,
    );
  }

  factory LocationDto.fromModel(Location model) {
    return LocationDto(
      name: model.name,
      address: model.address,
    );
  }

  Location toModel() {
    return Location(
      name: name,
      address: address,
    );
  }
}
