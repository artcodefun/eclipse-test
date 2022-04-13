import 'package:hive/hive.dart';

part 'Geo.g.dart';

@HiveType(typeId: 7)
class Geo {

  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double lng;


  Map<String, dynamic> toMap() {
    return {
      'lat': "$lat",
      'lng': "$lng",
    };
  }

  factory Geo.fromMap(Map<String, dynamic> map) {
    return Geo(
      lat: double.parse(map['lat']),
      lng: double.parse(map['lng']),
    );
  }

  const Geo({
    required this.lat,
    required this.lng,
  });

  Geo copyWith({
    double? lat,
    double? lng,
  }) {
    return Geo(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}