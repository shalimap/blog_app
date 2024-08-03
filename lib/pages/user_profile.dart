import 'package:blog_app/bloc/auth_bloc.dart';
import 'package:blog_app/pages/user_or_admin.dart';
import 'package:blog_app/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user/user_model.dart';
import '../widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Account',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: appbaritemcolor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('1.jpg'),
              ),
              const SizedBox(
                height: 50,
              ),
              nameAndEmail(context),
              const SizedBox(
                height: 200,
              ),
              ButtonLogout(
                text: 'LogOut',
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(LogoutUser());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserOrAdminPage()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget nameAndEmail(BuildContext context) {
    return Column(
      children: [
        Text(
          user.username,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          user.email,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
