import 'package:blog_app/pages/admin_login.dart';
import 'package:blog_app/pages/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class UserOrAdminPage extends StatelessWidget {
  const UserOrAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: 300, child: Lottie.asset('assets/animations/home.json')),
      const SizedBox(
        height: 50,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UserAdminButton(
                text: 'User',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginUserScreen(),
                    ),
                  );
                }),
            UserAdminButton(
                text: 'Admin',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginAdminScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    ]);
  }
}

// ignore: must_be_immutable
class UserAdminButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  UserAdminButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 165, 194, 216),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 188, 131, 199),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(4, 4))
            ]),
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 15, color: const Color.fromARGB(255, 78, 50, 39)),
        )),
      ),
    );
  }
}
