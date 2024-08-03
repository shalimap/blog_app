// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonLogout extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  ButtonLogout({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize: const WidgetStatePropertyAll(
              Size(250, 50),
            ),
            backgroundColor: const WidgetStatePropertyAll(
                Color.fromARGB(255, 188, 131, 199)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
