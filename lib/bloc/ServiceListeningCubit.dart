import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/services/Service.dart';
import 'package:testapp/services/ServiceMessage.dart';

import '../models/abstract/Model.dart';

/// Listen for [Service] updates and handles them with [onUpdateFromService] method
abstract class ServiceListeningCubit<State, ServiceModel extends Model> extends Cubit<State>{

  ServiceListeningCubit({required State initial, required Service<ServiceModel> service})
      :super(initial){
    _serviceStreamSubscription = service.stream.listen(onUpdateFromService);
  }

  late final StreamSubscription<ServiceMessage<ServiceModel>> _serviceStreamSubscription;

  onUpdateFromService(ServiceMessage<ServiceModel> message);

  @mustCallSuper
  @override
  Future<void> close() {
    _serviceStreamSubscription.cancel();
    return super.close();
  }

}