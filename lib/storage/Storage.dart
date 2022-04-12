
import 'package:testapp/models/abstract/Model.dart';

/// Used to load/save app data locally
abstract class Storage<M extends Model>{

  /// Saves [model] locally
  ///
  /// returns [model]'s id
  Future<int> save(M model);

  /// Deletes [model] that was saved locally
  Future delete(int id);

  /// Counts all [model] saved locally with [path]
  Future<int> count();

  /// Tries to find value of type [M] by [id]
  ///
  /// if value cannot be found returns null
  Future<M?> findById(int id);

  /// Returns all stored values of type [M]
  Future<Iterable<M>> getAll();
  

}