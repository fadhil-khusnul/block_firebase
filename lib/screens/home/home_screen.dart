import 'dart:io'; // Import File class
import 'package:block_firebase/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:block_firebase/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:block_firebase/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:block_firebase/screens/home/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            if (state.status == MyUserStatus.success) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PostScreen(
                            context.read<MyUserBloc>().state.user!),
                      ));
                },
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
              );
            } else {
              return const FloatingActionButton(
                onPressed: null,
                child: Icon(
                  CupertinoIcons.clear,
                  color: Colors.white,
                ),
              );

            }
          },
        ),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                return Row(
                  children: [
                    state.user!.picture == ""
                        ? GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 500,
                                  maxWidth: 500,
                                  imageQuality: 40);

                              if (image != null) {
                                setState(() {
                                  context.read<UpdateUserInfoBloc>().add(
                                      UploadPicture(
                                          image.path,
                                          context
                                              .read<MyUserBloc>()
                                              .state
                                              .user!
                                              .id));
                                });
                              }
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle),
                              child: Icon(
                                CupertinoIcons.person,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  maxHeight: 500,
                                  maxWidth: 500,
                                  imageQuality: 40);

                              if (image != null) {
                                setState(() {
                                  context.read<UpdateUserInfoBloc>().add(
                                      UploadPicture(
                                          image.path,
                                          context
                                              .read<MyUserBloc>()
                                              .state
                                              .user!
                                              .id));
                                });
                              }
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        state.user!.picture!,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Welcome ${state.user!.name} ")
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                },
                icon: Icon(
                  CupertinoIcons.square_arrow_right,
                  color: Theme.of(context).colorScheme.onPrimary,
                ))
          ],
        ),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, int i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  // height: 400,
                  // color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("2024-04-01 "),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // color: Colors.amber,
                          child: Text(
                              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia tempora beatae velit possimus esse incidunt aperiam optio a deleniti aspernatur."),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
