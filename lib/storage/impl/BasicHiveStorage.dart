import 'package:hive/hive.dart';
import 'package:testapp/models/abstract/Model.dart';
import 'package:testapp/storage/Storage.dart';


/// Storage implementation for Hive database
/// Hive should be initialized before this class can be used
class BasicHiveStorage<M extends Model> implements Storage<M>{
  
  BasicHiveStorage(this.path, TypeAdapter<M> typeAdapter){
    Hive.registerAdapter(typeAdapter);
    Hive.openBox<M>(path);
  }
  
  final String path;
  
  @override
  Future<M?> findById(dynamic id) async {
    return Hive.box<M>(path).get(id);
  }

  @override
  Future<Iterable<M>> getAll() async {
    return Hive.box<M>(path).values.cast<M>();
  }

  @override
  Future<dynamic> save(M model,) async {
    await Hive.box<M>(path).put(model.id, model);
    return model.id;
  }

  @override
  Future delete(dynamic id,) async {
    await Hive.box<M>(path).delete(id);
  }

  @override
  Future<int> count() async {
    return Hive.box<M>(path).length;
  }
  
}