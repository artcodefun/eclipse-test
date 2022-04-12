
import '../models/abstract/Model.dart';

enum AutoListModelStateStatus {
  created, loading, active
}

class AutoListModelState<M extends Model>{
  final AutoListModelStateStatus status;

  final List<M> autoList;

  final int offset;

  final bool canLoadNewer;

  final bool canLoadOlder;

  const AutoListModelState({
    this.status =AutoListModelStateStatus.created,
    this.offset = 0,
    this.autoList = const[],
    this.canLoadNewer =false,
    this.canLoadOlder=true
  });

  AutoListModelState<M> copyWith({
    AutoListModelStateStatus? status,
    List<M>? autoList,
    int? offset,
    bool? canLoadNewer,
    bool? canLoadOlder,
  }) {
    return AutoListModelState(
      status: status ?? this.status,
      autoList: autoList ?? this.autoList,
      offset: offset ?? this.offset,
      canLoadNewer: canLoadNewer ?? this.canLoadNewer,
      canLoadOlder: canLoadOlder ?? this.canLoadOlder,
    );
  }
}