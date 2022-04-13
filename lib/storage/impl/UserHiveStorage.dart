import 'package:hive/hive.dart';
import 'package:testapp/models/Geo.dart';
import 'package:testapp/models/User.dart';
import 'package:testapp/storage/UserStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

import '../../models/Address.dart';
import '../../models/Company.dart';

class UserHiveStorage extends BasicHiveStorage<User> implements UserStorage {
  UserHiveStorage(String path,)
      : super(path, UserAdapter()) {
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(CompanyAdapter());
    Hive.registerAdapter(GeoAdapter());
  }
}
