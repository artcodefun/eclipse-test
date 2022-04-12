
import 'package:testapp/models/abstract/Model.dart';

/// Used to load/save app data locally
abstract class Storage<M extends Model>{

  /// Saves [model] locally
  ///
  /// returns [model]'s id
  Future<dynamic> save(M model);

  /// Deletes [model] that was saved locally
  Future delete(dynamic id);

  /// Counts all [model] saved locally with [path]
  Future<int> count();

  /// Tries to find value of type [T] by [id]
  ///
  /// if value cannot be found returns null
  Future<M?> findById(dynamic id);

  /// Returns all stored values of type [T]
  Future<Iterable<M>> getAll();
  

}