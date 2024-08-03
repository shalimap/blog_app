// ignore_for_file: use_key_in_widget_constructors

import 'package:blog_app/bloc/auth_bloc.dart';
import 'package:blog_app/pages/user_home_page.dart';
import 'package:blog_app/pages/user_or_admin.dart';
import 'package:blog_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(hiveDatabase: HiveDatabase())..add(CheckAuthStatus()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        user: state.user,
                      )),
            );
          } else if (state is AuthInitial) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UserOrAdminPage()),
            );
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
