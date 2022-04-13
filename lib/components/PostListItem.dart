import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/pages/PostPage.dart';

import '../models/Post.dart';
import '../utils/color.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => PostPage(postId: post.id ,appBarColor: randColor(Random(post.id)),))),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 5),
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(25),
            color: randColor(Random(post.id))),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            post.title.length > 20
                ? post.title.substring(0, 20) + "..."
                : post.title,
            style: theme.textTheme.headline4?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          ),
          Text(
            post.body.length > 20
                ? post.body.substring(0, 20) + "..."
                : post.body,
            style: theme.textTheme.headline5?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          )
        ]),
      ),
    );
  }
}
