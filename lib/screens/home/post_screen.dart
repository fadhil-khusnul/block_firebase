import 'dart:developer';

import 'package:block_firebase/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

class PostScreen extends StatefulWidget {
  final MyUser myUser;
  const PostScreen(this.myUser, {super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Post post;

  @override
  void initState() {
    post = Post.empty;
    post.myUser = widget.myUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(post.toString());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text(
            "Create a Post",
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 10,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: "Enter post here...",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
