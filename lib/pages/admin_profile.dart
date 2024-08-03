import 'package:blog_app/pages/user_or_admin.dart';
import 'package:blog_app/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/admin_bloc.dart';
import '../widgets/logout_button.dart';

class AdminProfileScreen extends StatelessWidget {
  final String adminName;
  final String adminEmail;
  const AdminProfileScreen(
      {super.key, required this.adminEmail, required this.adminName});

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
            'Admin Account',
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
                backgroundImage: AssetImage('2.jpg'),
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
                  BlocProvider.of<AdminBloc>(context)
                      .add(AdminLogoutRequested());
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
          adminName,
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
          adminEmail,
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
