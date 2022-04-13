import 'package:flutter/cupertino.dart';
import 'package:testapp/bloc/AutoListModelState.dart';
import 'package:testapp/bloc/ServiceListeningCubit.dart';
import 'package:testapp/services/Service.dart';
import 'package:testapp/services/ServiceMessage.dart';

import '../models/abstract/Model.dart';

/// Settings required to automatically update list of models
class AutoListSettings {
  /// Size of the list
  final int size;

  /// Amount of models remaining 'unseen' before list should load new models
  final int updateWhenReachFromEnd;

  /// Amount of new models that should be loaded into the list
  final int updateAmount;

  const AutoListSettings({
    this.size = 30,
    this.updateWhenReachFromEnd = 5,
    this.updateAmount = 15,
  });
}

/// Loads list of models that updates when new models requested
///
/// should be used with widgets like [ListView.builder]
class AutoListModelCubit<M extends Model>
    extends ServiceListeningCubit<AutoListModelState<M>, M> {
  AutoListModelCubit(
      {required this.service, this.settings = const AutoListSettings()})
      : super(initial: const AutoListModelState(), service: service);

  AutoListSettings settings;

  Service<M> service;

  bool _updating = false;

  /// Loads model based on its [position] without updating the list
  /// only models that are currently in the list will be available with this method
  M loadModel(int position) {
    int listPosition =
        (position - state.offset).clamp(0, state.autoList.length - 1);
    return state.autoList[listPosition];
  }

  /// Loads model based on its [position] and updates list with new models if needed
  M loadModelWithListAutoUpdate(int position) {
    int listPosition =
        (position - state.offset).clamp(0, state.autoList.length - 1);

    if (listPosition <= settings.updateWhenReachFromEnd &&
        state.canLoadNewer &&
        !_updating) {
      _updating = true;
      loadNewer(settings.updateAmount).whenComplete(() => _updating = false);
    }

    if (listPosition >= settings.size - settings.updateWhenReachFromEnd &&
        state.canLoadOlder &&
        !_updating) {
      _updating = true;
      loadOlder(settings.updateAmount).whenComplete(() => _updating = false);
    }

    return state.autoList[listPosition];
  }

  /// Loads latest models into list
  loadLast() async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    var models = await service.loadLast(settings.size);
    models.sort((a, b) => b.id.compareTo(a.id));
    emit(AutoListModelState(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: 0,
        canLoadNewer: false,
        canLoadOlder: models.length == settings.size));
  }

  /// Updates list with newer models
  Future loadNewer(int amount) async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    int fromId = state.autoList.first.id + 1;
    List<M> newerModels = await service.loadSet(fromId, fromId + amount);

    if (newerModels.isEmpty) {
      emit(state.copyWith(canLoadNewer: false));
      return;
    }

    newerModels.sort((a, b) => b.id.compareTo(a.id));

    List<M> models = newerModels +
        state.autoList.take(settings.size - newerModels.length).toList();

    emit(state.copyWith(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: state.offset - newerModels.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }

  /// Updates list with older models
  Future loadOlder(int amount) async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    int fromId = state.autoList.last.id - 1;
    List<M> olderModels = await service.loadSet(fromId - amount, fromId);

    if (olderModels.isEmpty) {
      emit(state.copyWith(canLoadOlder: false));
      return;
    }

    olderModels.sort((a, b) => b.id.compareTo(a.id));

    List<M> models =
        state.autoList.skip(olderModels.length).toList() + olderModels;

    emit(state.copyWith(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: state.offset + olderModels.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }

  @override
  onUpdateFromService(ServiceMessage<M> message) {
    var list = state.autoList;
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == message.model.id) list[i] = message.model;
    }
    emit(state.copyWith(autoList: state.autoList));
  }
}
