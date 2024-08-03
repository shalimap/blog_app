// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:blog_app/pages/admin_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../bloc/admin_bloc.dart';
import '../widgets/color.dart';
import '../widgets/delayed_animation.dart';
import '../widgets/login_button.dart';
import '../widgets/textfield.dart';

class LoginAdminScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final adminEmailController = TextEditingController();
  final passwordController = TextEditingController();
  ValueNotifier<bool> isVisibile = ValueNotifier<bool>(true);

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Lottie.asset('assets/animations/login.json'),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    DelayedAnimation(
                        aniDuration: 900,
                        aniOffsetX: 0.0,
                        aniOffsetY: 1.0,
                        delayedAnimation: 800,
                        child: signInText()),
                    const SizedBox(height: 5),
                    DelayedAnimation(
                      aniDuration: 900,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.35,
                      delayedAnimation: 1000,
                      child: subText(),
                    ),
                    const SizedBox(height: 150),
                    DelayedAnimation(
                      aniDuration: 800,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.45,
                      delayedAnimation: 900,
                      child: CustomTextFieldWidget(
                        color: Colors.transparent,
                        text: 'Email',
                        icon: Icons.email,
                        controller: adminEmailController,
                        isObscured: false,
                        validator: _validateEmail,
                        suffix: const SizedBox(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    DelayedAnimation(
                      aniDuration: 700,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.45,
                      delayedAnimation: 900,
                      child: ListenableBuilder(
                        listenable: isVisibile,
                        builder: (context, child) {
                          return CustomTextFieldWidget(
                            color: Colors.transparent,
                            text: 'Password',
                            icon: Icons.password,
                            controller: passwordController,
                            validator: _validatePassword,
                            suffix: GestureDetector(
                              onTap: () {
                                isVisibile.value = !isVisibile.value;
                              },
                              child: isVisibile.value
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.blueGrey,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.blueGrey,
                                    ),
                            ),
                            isObscured: isVisibile.value,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 60),
                    DelayedAnimation(
                      aniDuration: 500,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.35,
                      delayedAnimation: 900,
                      child: BlocListener<AdminBloc, AdminState>(
                        listener: (context, state) {
                          if (state is AdminLoginSuccess) {
                            // Navigate to another screen or show a success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text("login successfull"),
                                backgroundColor: successcolor,
                              ),
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminHomeScreen()));
                          } else if (state is AdminLoginFailure) {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                                backgroundColor: errorcolor,
                              ),
                            );
                          }
                        },
                        child: ButtonLogin(
                          text: 'Login',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              BlocProvider.of<AdminBloc>(context).add(
                                AdminLoginRequested(
                                  email: adminEmailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center subText() {
    return Center(
      child: Text(
        'Welcome Back',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 78, 50, 39),
        ),
      ),
    );
  }

  Center signInText() {
    return Center(
      child: Text(
        'Admin',
        style: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 78, 50, 39),
        ),
      ),
    );
  }
}
