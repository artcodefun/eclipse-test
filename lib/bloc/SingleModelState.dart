import 'package:testapp/models/abstract/Model.dart';

enum SingleModelStateStatus{
  created, loading, active, error
}

class SingleModelState<M extends Model> {
  final SingleModelStateStatus status;
  final M? model;

  const SingleModelState({
    this.status = SingleModelStateStatus.created,
    this.model,
  });

  SingleModelState<M> copyWith({
    SingleModelStateStatus? status,
    M? model,
    bool updateNullFields = false
  }) {
    return SingleModelState(
      status: status ?? this.status,
      model: model ?? (updateNullFields ? model : this.model),
    );
  }
}