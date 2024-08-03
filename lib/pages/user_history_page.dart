import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../bloc/auth_bloc.dart';
import '../models/post/post_model.dart';
import '../models/user/user_model.dart';
import '../repositories/user_repository.dart';
import '../widgets/color.dart';

class HistoryScreen extends StatelessWidget {
  final User user;

  const HistoryScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(hiveDatabase: HiveDatabase()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbarbackground,
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
            'History',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: appbaritemcolor,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Blogs',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: Hive.box<PostModel>('posts').listenable(),
                builder: (context, Box<PostModel> box, _) {
                  final posts = box.values
                      .where((post) => post.authorId == user.id)
                      .toList();

                  if (posts.isEmpty) {
                    return Center(
                      child: Text(
                        'No posts available',
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, top: 8, bottom: 8, right: 10),
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: colorList[index % colorList.length],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.id,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          // overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Content: ${post.content}",
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          // overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Approved: ${post.isPublished}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    // overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
