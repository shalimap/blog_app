// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldWidget extends StatelessWidget {
  String text;
  IconData icon;
  TextEditingController controller;
  FormFieldValidator<String>? validator;
  Widget suffix;
  bool isObscured;
  Color color;

  CustomTextFieldWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.suffix,
    required this.isObscured,
    required this.color,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          border: Border.all(color: Colors.black26),
        ),
        child: TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isObscured,
          decoration: InputDecoration(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 100),
            label: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            prefixIcon: Icon(icon, color: Colors.black54),
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
