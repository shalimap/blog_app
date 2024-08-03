// ignore_for_file: use_key_in_widget_constructors

import 'package:blog_app/bloc/auth_bloc.dart';
import 'package:blog_app/pages/user_login_page.dart';
import 'package:blog_app/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../models/user/user_model.dart';
import '../widgets/delayed_animation.dart';
import '../widgets/login_button.dart';
import '../widgets/textfield.dart';
import 'user_home_page.dart';

class RegistrationUserScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Registration Success: ${state.user.username}"),
            backgroundColor: successcolor,
          ));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        user: state.user,
                      )));
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failure: ${state.error}"),
            backgroundColor: errorcolor,
          ));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Lottie.asset('assets/animations/signup.json'),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    DelayedAnimation(
                        aniDuration: 900,
                        aniOffsetX: 0.0,
                        aniOffsetY: 1.0,
                        delayedAnimation: 800,
                        child: signUpText()),
                    const SizedBox(height: 5),
                    DelayedAnimation(
                        aniDuration: 900,
                        aniOffsetX: 0.0,
                        aniOffsetY: 0.35,
                        delayedAnimation: 1000,
                        child: subText()),
                    const SizedBox(height: 100),
                    DelayedAnimation(
                      aniDuration: 800,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.45,
                      delayedAnimation: 900,
                      child: CustomTextFieldWidget(
                        text: 'Username',
                        icon: Icons.person,
                        controller: usernameController,
                        isObscured: false,
                        color: textfieldcolor,
                        suffix: const SizedBox(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DelayedAnimation(
                      aniDuration: 800,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.45,
                      delayedAnimation: 900,
                      child: CustomTextFieldWidget(
                        text: 'Email',
                        icon: Icons.email,
                        controller: emailController,
                        isObscured: false,
                        color: textfieldcolor,
                        suffix: const SizedBox(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DelayedAnimation(
                      aniDuration: 700,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.45,
                      delayedAnimation: 900,
                      child: CustomTextFieldWidget(
                        text: 'Password',
                        icon: Icons.password,
                        controller: passwordController,
                        isObscured: false,
                        suffix: const SizedBox(),
                        color: textfieldcolor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DelayedAnimation(
                      aniDuration: 700,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.45,
                      delayedAnimation: 900,
                      child: CustomTextFieldWidget(
                        text: 'Confirm Password',
                        icon: Icons.password,
                        controller: confirmPasswordController,
                        isObscured: false,
                        suffix: const SizedBox(),
                        color: textfieldcolor,
                      ),
                    ),
                    const SizedBox(height: 60),
                    DelayedAnimation(
                      aniDuration: 500,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.35,
                      delayedAnimation: 900,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return ButtonLogin(
                            text: 'Register',
                            onPressed: () {
                              if (usernameController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      const Text("Please enter your username"),
                                  backgroundColor: errorcolor,
                                ));
                                return;
                              }
                              if (emailController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      const Text("Please enter your email"),
                                  backgroundColor: errorcolor,
                                ));
                                return;
                              }
                              if (passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      const Text("Please enter your password"),
                                  backgroundColor: errorcolor,
                                ));
                                return;
                              }
                              if (confirmPasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                      "Please confirm your password"),
                                  backgroundColor: errorcolor,
                                ));
                                return;
                              }
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text("Passwords do not match"),
                                  backgroundColor: errorcolor,
                                ));
                                return;
                              }
                              final user = User(
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                isBanned: false,
                              );
                              BlocProvider.of<AuthBloc>(context)
                                  .add(RegisterUser(user));
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    DelayedAnimation(
                        aniDuration: 500,
                        aniOffsetX: 0.0,
                        aniOffsetY: 0.35,
                        delayedAnimation: 1000,
                        child: alreadyHaveAccountText(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center alreadyHaveAccountText(context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginUserScreen())),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Already have an account ? ',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '  Login',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color.fromARGB(255, 78, 50, 39),
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
      ),
    );
  }

  Center subText() {
    return Center(
      child: Text(
        'Create your account',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 78, 50, 39),
        ),
      ),
    );
  }

  Center signUpText() {
    return Center(
      child: Text(
        'SignUp',
        style: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 78, 50, 39),
        ),
      ),
    );
  }
}
