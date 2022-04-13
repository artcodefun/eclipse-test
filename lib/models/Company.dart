
import 'package:hive/hive.dart';

part 'Company.g.dart';

@HiveType(typeId: 2)
class Company {

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String catchPhrase;
  @HiveField(2)
  final String bs;

  const Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? bs,
  }) {
    return Company(
      name: name ?? this.name,
      catchPhrase: catchPhrase ?? this.catchPhrase,
      bs: bs ?? this.bs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'bs': bs,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map['name'] as String,
      catchPhrase: map['catchPhrase'] as String,
      bs: map['bs'] as String,
    );
  }
}