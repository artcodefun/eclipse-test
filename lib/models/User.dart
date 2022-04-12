import 'package:hive/hive.dart';
import 'package:testapp/models/Address.dart';
import 'package:testapp/models/Company.dart';

import 'abstract/Model.dart';
import 'abstract/Serializer.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class User extends Model {


  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final Address address;
  @HiveField(5)
  final String phone;
  @HiveField(6)
  final String website;
  @HiveField(7)
  final Company company;


  @override
  List<Object?> get props =>
      [
        id,
        name,
        username,
        email,
        address,
        phone,
        website,
        company
      ];

   User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });



  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      address: map['address'] as Address,
      phone: map['phone'] as String,
      website: map['website'] as String,
      company: map['company'] as Company,
    );
  }
}
class UserSerializer implements Serializer<User> {
  @override
  User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      address: Address.fromMap(map['address']),
      phone: map['phone'] as String,
      website: map['website'] as String,
      company: Company.fromMap(map['company']),
    );
  }

  @override
  Map<String, dynamic> toMap(User model) {
    return {
      'id': model.id,
      'name': model.name,
      'username': model.username,
      'email': model.email,
      'address': model.address.toMap(),
      'phone': model.phone,
      'website': model.website,
      'company': model.company.toMap(),
    };
  }
}

