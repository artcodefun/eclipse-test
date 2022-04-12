import 'dart:async';
import 'package:testapp/services/Service.dart';
import 'package:testapp/services/ServiceMessage.dart';

import '../../api/ApiHandler.dart';
import '../../models/abstract/Model.dart';
import '../../models/abstract/Serializer.dart';
import '../../storage/Storage.dart';

/// Implements basic [Service] functionality
class BasicService<M extends Model> implements Service<M> {

  /// Depends on local [storage],
  /// [apiHandler] with [apiPath] and [serializer] for remote storage communication
  ///
  /// [preSave] could be provided in order to do something with model right before saving to [storage]
  /// like downloading files that model linked to
  BasicService(
      {required this.storage,
        required this.apiHandler,
        required this.apiPath,
        required this.serializer,
        this.preSave});

  final Storage<M> storage;
  final ApiHandler apiHandler;
  final String apiPath;
  final Serializer<M> serializer;

  final StreamController<ServiceMessage<M>> _controller = StreamController.broadcast();

  _pathFromId(int id) => apiPath + "$id";

  ApiConverter<M> get converter =>
          (d) => serializer.fromMap(d as Map<String, dynamic>);

  ApiReverseConverter<M> get reverseConverter => serializer.toMap;

  ApiConverter<List<M>> get listConverter => (d) {
    return (d as List)
        .map((e) => serializer.fromMap(e as Map<String, dynamic>))
        .toList();
  };

  final Future<M> Function(M model)? preSave;

  Future<M> save(M model) async {
    if (preSave != null) {
      model = await preSave!(model);
    }
    await storage.save(model);
    _notifyListeners(model);
    return model;
  }

  _notifyListeners(M model,
      {ServiceMessageType type = ServiceMessageType.updateModel}) {
    _controller.sink.add(ServiceMessage(type: type, model: model));
  }

  @override
  Future<M?> load(int id) async {
    M? model = await storage.findById(id);
    if (model != null) {
      return model;
    }
    model = await pull(id);
    return model;
  }

  @override
  Future<M?> pull(int id) async {
    try {
      M model = await apiHandler.get(_pathFromId(id), {}, converter);

      model = await save(model);
      return model;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<M>> pullLast(int n) async {
    List<M> models;
    try {
      models = await apiHandler.get<List<M>>(
          apiPath, {"_sort": "id", "_order": "desc", "_limit": n},
          listConverter);
    } catch (e){ models =[];}

    for (int i = 0; i < models.length; i++) {
      models[i] = await save(models[i]);
    }
    return models;
  }

  @override
  Future<List<M>> loadSet(int beginId, int endId) async {
    List<M> models = [];
    List<int> notFound = [];

    for (int id = beginId; id <= endId; id++) {
      M? model = await storage.findById(id);
      if (model != null) {
        models.add(model);
      } else {
        notFound.add(id);
      }
    }

    models.addAll(await pullWithIds(notFound));

    return models;
  }

  @override
  Future push(M model) async {
    await apiHandler.post(_pathFromId(model.id), model, reverseConverter);
    await save(model);
  }

  @override
  Future<List<M>> pullWithIds(List<int> ids) async{
    List<M> models;
    String queryString = "?";
    for (int id in ids){
      queryString+="id=$id&";
    }
    try{
    models = await apiHandler.get<List<M>>(
        apiPath+queryString, {}, listConverter);
    } catch (e){ models =[];}

    for (int i = 0; i < models.length; i++) {
      models[i] = await save(models[i]);
    }
    return models;
  }

  @override
  Stream<ServiceMessage<M>> get stream => _controller.stream;



}
