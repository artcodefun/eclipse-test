import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testapp/models/Address.dart';
import 'package:testapp/models/Company.dart';
import 'package:testapp/models/User.dart';
import 'package:testapp/services/UserService.dart';
import 'package:testapp/services/impl/UserServiceImpl.dart';
import 'package:testapp/storage/UserStorage.dart';
import 'package:testapp/storage/impl/UserHiveStorage.dart';

import '../api/ApiHandler.dart';
import '../api/impl/DioApiHandler.dart';
import '../models/Album.dart';
import '../models/Comment.dart';
import '../models/Photo.dart';
import '../models/Post.dart';
import '../services/AlbumService.dart';
import '../services/CommentService.dart';
import '../services/PhotoService.dart';
import '../services/PostService.dart';
import '../services/impl/AlbumServiceImpl.dart';
import '../services/impl/CommentServiceImpl.dart';
import '../services/impl/PhotoServiceImpl.dart';
import '../services/impl/PostServiceImpl.dart';
import '../storage/AlbumStorage.dart';
import '../storage/CommentStorage.dart';
import '../storage/PhotoStorage.dart';
import '../storage/PostStorage.dart';
import '../storage/impl/AlbumHiveStorage.dart';
import '../storage/impl/CommentHiveStorage.dart';
import '../storage/impl/PhotoHiveStorage.dart';
import '../storage/impl/PostHiveStorage.dart';
import 'Endpoints.dart';

/// Manages dependency injection
class AppModule {
  Future<Injector> initialise(Injector injector) async {
    // initializing external packages
    String appDirectory = (await getApplicationDocumentsDirectory()).path;
    Hive.init(appDirectory);

    //then load data access entities
    var dah = DioApiHandler();
    await dah.init(Endpoints.baseUrl);

    injector.map<ApiHandler>((i) => dah, isSingleton: true);

    //then load storages
    injector.map<UserStorage>(
        (i) => UserHiveStorage(Endpoints.userSavePath),
        isSingleton: true);

    injector.map<AlbumStorage>(
        (i) => AlbumHiveStorage(Endpoints.albumSavePath),
        isSingleton: true);

    injector.map<CommentStorage>(
        (i) => CommentHiveStorage(Endpoints.commentSavePath),
        isSingleton: true);

    injector.map<PhotoStorage>(
        (i) => PhotoHiveStorage(Endpoints.photoSavePath),
        isSingleton: true);

    injector.map<PostStorage>(
        (i) => PostHiveStorage(Endpoints.postSavePath),
        isSingleton: true);

    //then load services
    injector.map<UserService>(
        (i) => UserServiceImpl(
            storage: i.get(),
            apiHandler: i.get(),
            apiPath: Endpoints.userApiPath,
            serializer: UserSerializer()),
        isSingleton: true);

    injector.map<AlbumService>(
        (i) => AlbumServiceImpl(
            storage: i.get(),
            apiHandler: i.get(),
            apiPath: Endpoints.albumApiPath,
            serializer: AlbumSerializer()),
        isSingleton: true);

    injector.map<CommentService>(
        (i) => CommentServiceImpl(
            storage: i.get(),
            apiHandler: i.get(),
            apiPath: Endpoints.commentApiPath,
            serializer: CommentSerializer()),
        isSingleton: true);

    injector.map<PhotoService>(
        (i) => PhotoServiceImpl(
            storage: i.get(),
            apiHandler: i.get(),
            apiPath: Endpoints.photoApiPath,
            serializer: PhotoSerializer()),
        isSingleton: true);

    injector.map<PostService>(
        (i) => PostServiceImpl(
            storage: i.get(),
            apiHandler: i.get(),
            apiPath: Endpoints.postApiPath,
            serializer: PostSerializer()),
        isSingleton: true);

    return injector;
  }
}
