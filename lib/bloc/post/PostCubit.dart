import 'package:testapp/bloc/SingleModelCubit.dart';
import 'package:testapp/bloc/SingleModelState.dart';
import 'package:testapp/services/PostService.dart';

import '../../models/Post.dart';

class PostCubit extends SingleModelCubit<Post> {
  PostCubit({
    required PostService service,
    Post? post,
  }) : super(
      initial: SingleModelState(
          status: post == null
              ? SingleModelStateStatus.created
              : SingleModelStateStatus.active,
          model: post),
      service: service);
}
