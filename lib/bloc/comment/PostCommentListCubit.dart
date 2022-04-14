import 'package:testapp/bloc/AutoListModelCubit.dart';
import 'package:testapp/models/Comment.dart';
import 'package:testapp/services/CommentService.dart';

import '../AutoListModelState.dart';

class PostCommentListCubit extends AutoListModelCubit<Comment> {
  PostCommentListCubit({required this.service, required this.postId})
      : super(service: service);

  @override
  final CommentService service;

  final int postId;

  @override
  loadLast() async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    var models = await service.loadLastCommentsByPost(postId, settings.size, 0);
    models.sort((a, b) => a.id.compareTo(b.id));
    emit(AutoListModelState(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: 0,
        canLoadNewer: false,
        canLoadOlder: models.length == settings.size));
  }

  @override
  Future loadNewer(int amount) async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    List<Comment> newerModels = await service.loadLastCommentsByPost(postId,
        amount, (state.offset - amount).clamp(0, double.maxFinite.toInt()));

    if (newerModels.isEmpty) {
      emit(state.copyWith(status: AutoListModelStateStatus.active, canLoadNewer: false));
      return;
    }

    newerModels.sort((a, b) => a.id.compareTo(b.id));

    List<Comment> models = newerModels +
        state.autoList.take(settings.size - newerModels.length).toList();

    emit(state.copyWith(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: state.offset - newerModels.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }

  @override
  Future loadOlder(int amount) async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    List<Comment> olderModels = await service.loadLastCommentsByPost(
        postId, amount, state.offset + state.autoList.length);

    if (olderModels.isEmpty) {
      emit(state.copyWith(status: AutoListModelStateStatus.active, canLoadOlder: false));
      return;
    }

    olderModels.sort((a, b) => a.id.compareTo(b.id));

    List<Comment> models =
        state.autoList.skip(olderModels.length).toList() + olderModels;

    emit(state.copyWith(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: state.offset + olderModels.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }

  Future pushComment(Comment c) async {
    try {
      Comment comment;
      comment = await service.push(c);
      if (!state.canLoadOlder) {
        List<Comment> comments = state.autoList;
        int offset =state.offset;
        comments.add(comment);

        if(comments.length>settings.size){
          int diff = comments.length- settings.size;
          comments.removeRange(0, diff);
          offset+=diff;
        }

        emit(state.copyWith(
          autoList: comments,
          offset: offset,
        ));
      }
    } finally {}
  }
}
