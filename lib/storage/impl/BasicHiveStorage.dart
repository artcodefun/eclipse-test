import 'package:hive/hive.dart';
import 'package:testapp/models/abstract/Model.dart';
import 'package:testapp/storage/Storage.dart';


/// Storage implementation for Hive database
/// Hive should be initialized before this class can be used
class BasicHiveStorage<M extends Model> implements Storage<M>{
  
  BasicHiveStorage(this.path, TypeAdapter<M> typeAdapter){
    Hive.registerAdapter(typeAdapter);
  }
  
  final String path;

  /// Should be called before any other method
  Future<BasicHiveStorage> init()async{
    await Hive.openBox<M>(path);
    return this;
  }
  
  @override
  Future<M?> findById(int id) async {
    return Hive.box<M>(path).get(id);
  }

  @override
  Future<Iterable<M>> getAll() async {
    return Hive.box<M>(path).values.cast<M>();
  }

  @override
  Future<int> save(M model,) async {
    await Hive.box<M>(path).put(model.id, model);
    return model.id;
  }

  @override
  Future delete(int id,) async {
    await Hive.box<M>(path).delete(id);
  }

  @override
  Future<int> count() async {
    return Hive.box<M>(path).length;
  }

  @override
  Future<Iterable<M>> getLast(int n) async{
    var list = Hive.box<M>(path).values.toList();
    list.sort((a,b)=>b.id.compareTo(a.id));
    return list.take(n);
  }
  
}