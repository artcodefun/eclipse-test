import 'package:testapp/bloc/ServiceListeningCubit.dart';
import 'package:testapp/bloc/SingleModelState.dart';
import 'package:testapp/services/Service.dart';
import 'package:testapp/services/ServiceMessage.dart';

import '../models/abstract/Model.dart';

/// Loads one model
///
/// should be used for detailed model views or something similar
class SingleModelCubit<M extends Model>
    extends ServiceListeningCubit<SingleModelState<M>, M> {
  SingleModelCubit({required SingleModelState<M> initial, required this.service})
      : super(initial: initial, service: service);

  final Service<M> service;

  loadModel(int id) async{
    emit(state.copyWith(status: SingleModelStateStatus.loading));
    M? model = await service.load(id);
    emit(state.copyWith(model: model, status: model==null ? SingleModelStateStatus.error : SingleModelStateStatus.active));
  }

  @override
  onUpdateFromService(ServiceMessage<M> message) {
    if (state.model?.id != message.model.id) return;
    if (state.model == message.model) return;
    emit(state.copyWith(model: message.model));
  }
}
