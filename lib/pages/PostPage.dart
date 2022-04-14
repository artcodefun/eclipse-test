import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:testapp/bloc/SingleModelState.dart';
import 'package:testapp/bloc/comment/PostCommentListCubit.dart';
import 'package:testapp/bloc/post/PostCubit.dart';
import 'package:testapp/bloc/post/UserPostListCubit.dart';
import 'package:testapp/bloc/user/UserCubit.dart';
import 'package:testapp/components/CommentListItem.dart';
import 'package:testapp/components/HalfFixedScrollView.dart';
import 'package:testapp/models/Post.dart';
import 'package:testapp/pages/dialogs/NewCommentDialog.dart';

import '../bloc/AutoListModelState.dart';
import '../models/Comment.dart';
import '../models/User.dart';
import '../utils/color.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key, required this.postId, this.appBarColor})
      : super(key: key);

  final int postId;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => PostCubit(
              service: Provider.of<Injector>(context, listen: false).get())
            ..loadModel(postId),
        ),
        BlocProvider(
          create: (ctx) => PostCommentListCubit(
              service: Provider.of<Injector>(context, listen: false).get(),
              postId: postId)
            ..loadLast(),
        ),
      ],
      child: BlocBuilder<PostCubit, SingleModelState<Post>>(
        builder: (ctx, postState) {
          PostSerializer us = PostSerializer();
          bool active = postState.status == SingleModelStateStatus.active;
          Widget body = !active
              ? const Center(child: CircularProgressIndicator())
              : BlocBuilder<PostCommentListCubit, AutoListModelState<Comment>>(
                  builder: (ctx, commentState) {
                    bool active =
                        commentState.status == AutoListModelStateStatus.active;
                    PostCommentListCubit pclc = ctx.read();
                    return HalfFixedScrollView(
                      fixedPart: [
                        for (var v in us.toMap(postState.model!).entries)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  v.key + " : ",
                                  style: theme.textTheme.headline6,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "${v.value}",
                                  style: theme.textTheme.headline6,
                                ))
                              ],
                            ),
                          ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "Comments :",
                                style: theme.textTheme.headline5,
                              ),
                            ),
                          ],
                        ),
                      ],
                      builder: (ctx, i) => CommentListItem(
                          comment: pclc.loadModelWithListAutoUpdate(i)),
                      buildChildrenCount:
                          commentState.autoList.length + commentState.offset,
                      footerPart: [
                        if (active)
                          const SizedBox(
                            height: 100,
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          )
                      ],
                    );
                  },
                );
          return Scaffold(
              appBar: AppBar(
                backgroundColor: appBarColor,
                title: Text(postState.model?.id.toString() ?? ""),
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  Comment? c = await showDialog(
                      context: context,
                      builder: (ctx) => NewCommentDialog(postId: postId));

                  if (c == null) return;
                  Provider.of<PostCommentListCubit>(ctx, listen: false)
                      .pushComment(c);
                },
              ),
              body: body);
        },
      ),
    );
  }
}
