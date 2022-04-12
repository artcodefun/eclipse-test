import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/models/abstract/Model.dart';
import 'package:testapp/services/ServiceMessage.dart';

/// Provides all functionality needed to work with model of type [M]
///
/// emits [ServiceMessages] to provide listeners with relevant information
abstract class Service<M extends Model> implements Streamable<ServiceMessage<M>>{

  /// Tries to load model of type [M] with id [id]
  ///
  /// should first try to load from local storage and then pull from remote one
  ///
  /// if model cannot be found returns null
  Future<M?> load(int id);

  /// Tries to load models of type [M] with [beginId] <= id <= [endId]
  ///
  /// should first try to load from local storage and then pull from remote one
  Future<List<M>> loadSet(int beginId, int endId);

  /// Tries to pull model from remote storage and then update/save it locally
  ///
  /// looks for model of type [M] with id [id]
  /// if model cannot be found returns null
  Future<M?> pull(int id);

  /// Tries to pull [n] last models from remote storage
  Future<List<M>> pullLast(int n);

  /// Tries to update model from remote storage with [model] value
  Future push(M model);
}