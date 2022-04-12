
import 'Model.dart';

/// Tries to serialize/deserialize [T]
abstract class Serializer<T extends Model>{

  /// Converts Map<String, dynamic> [map] to [T]
  T fromMap(Map<String, dynamic> map);

  /// Converts [model] to Map<String, dynamic>
  Map<String, dynamic> toMap(T model);
}