import 'package:testapp/bloc/AutoListModelCubit.dart';
import 'package:testapp/services/Service.dart';
import 'package:testapp/services/UserService.dart';

import '../../models/User.dart';

class UserListCubit extends AutoListModelCubit<User>{
  UserListCubit({required UserService service}) : super(service: service);

}