import 'dart:math';

import 'package:hive/hive.dart';
import 'package:testapp/models/Geo.dart';

part 'Address.g.dart';

@HiveType(typeId: 1)
class Address {

  @HiveField(0)
  final String street;
  @HiveField(1)
  final String suite;
  @HiveField(2)
  final String city;
  @HiveField(3)
  final String zipcode;
  @HiveField(4)
  final Geo geo;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) {
    return Address(
      street: street ?? this.street,
      suite: suite ?? this.suite,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
      geo: geo ?? this.geo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'geo': geo.toMap(),
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] as String,
      suite: map['suite'] as String,
      city: map['city'] as String,
      zipcode: map['zipcode'] as String,
      geo: Geo.fromMap(map["geo"]),
    );
  }
}