
import '../models/abstract/Model.dart';

enum ServiceMessageType {
  newModel, updateModel, deleteModel
}

class ServiceMessage<M extends Model>{

  final ServiceMessageType type;
  final M model;

  const ServiceMessage({
    required this.type,
    required this.model,
  });

}