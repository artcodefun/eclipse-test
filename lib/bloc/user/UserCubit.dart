import 'package:testapp/bloc/SingleModelCubit.dart';
import 'package:testapp/bloc/SingleModelState.dart';
import 'package:testapp/services/UserService.dart';

import '../../models/User.dart';


class UserCubit extends SingleModelCubit<User> {
  UserCubit(
      {required SingleModelState<User> initial, required UserService service})
      : super(initial: initial, service: service);
}
