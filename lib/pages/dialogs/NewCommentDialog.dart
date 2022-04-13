import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/models/Comment.dart';

class NewCommentDialog extends StatelessWidget {
  NewCommentDialog({Key? key, required this.postId}) : super(key: key);

  String name = "",
      email = "",
      body = "";

  int postId;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (s) => email = s,
              style: theme.textTheme.headline6,
              decoration: const InputDecoration(
                  labelText: "email",
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.all(5)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (s) => name = s,
              style: theme.textTheme.headline6,
              decoration: const InputDecoration(
                  labelText: "name",
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.all(5)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (s) => body = s,
              style: theme.textTheme.headline6,
              minLines: 3,
              maxLines: 3,
              decoration: const InputDecoration(
                  labelText: "body",
                  border: OutlineInputBorder(),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.all(5)),
            ),
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pop<Comment>(Comment(
                id: 0,
                postId: postId,
                name: name,
                body: body,
                email: email));
          }, child: Text("Send", style: theme.textTheme.headline6,))
        ],
      ),
    );
  }
}
