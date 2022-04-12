import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/UserService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/UserStorage.dart';

import '../../models/User.dart';

class UserServiceImpl extends BasicService<User> implements UserService {
  UserServiceImpl(
      {required UserStorage storage,
      required ApiHandler apiHandler,
      required String apiPath,
      required Serializer<User> serializer})
      : super(
            storage: storage,
            apiHandler: apiHandler,
            apiPath: apiPath,
            serializer: serializer);
}
