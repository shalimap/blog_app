// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../bloc/post_bloc.dart';
import '../models/post/post_model.dart';
import '../models/user/user_model.dart';
import '../widgets/color.dart';
import '../widgets/login_button.dart';
import '../widgets/textfield.dart';

class PostScreen extends StatelessWidget {
  User user;
  PostScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarbackground,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: appbaritemcolor,
          ),
        ),
        title: Text(
          'Post',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: appbaritemcolor,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Lottie.asset('assets/animations/post.json'),
          ),
          BlocListener<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Post added successfully!'),
                    backgroundColor: successcolor,
                  ),
                );
                Navigator.pop(context);
              } else if (state is PostFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to add post: ${state.error}'),
                  backgroundColor: errorcolor,
                ));
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    CustomTextFieldWidget(
                      color: Colors.transparent,
                      text: 'Title',
                      icon: Icons.title,
                      controller: titleController,
                      isObscured: false,
                      suffix: const SizedBox(),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldWidget(
                      color: Colors.transparent,
                      text: 'Content',
                      icon: Icons.content_paste_rounded,
                      controller: contentController,
                      isObscured: false,
                      suffix: const SizedBox(),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 70),
                    ButtonLogin(
                      onPressed: () {
                        PostModel newPost = PostModel(
                          id: '',
                          title: titleController.text,
                          content: contentController.text,
                          authorId: user.id,
                          isPublished: false, // or set it as needed
                          response: '', // or set it as needed
                        );
                        print(user.id);
                        context.read<PostBloc>().add(PostAdding(newPost));
                      },
                      text: 'Post',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
