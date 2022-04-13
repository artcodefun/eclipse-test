import 'package:testapp/bloc/SingleModelCubit.dart';
import 'package:testapp/bloc/SingleModelState.dart';
import 'package:testapp/services/UserService.dart';

import '../../models/User.dart';

class UserCubit extends SingleModelCubit<User> {
  UserCubit({
    required UserService service,
    User? user,
  }) : super(
            initial: SingleModelState(
                status: user == null
                    ? SingleModelStateStatus.created
                    : SingleModelStateStatus.active,
            model: user),
            service: service);
}
