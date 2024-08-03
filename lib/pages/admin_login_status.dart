import 'package:blog_app/bloc/admin_bloc.dart';
import 'package:blog_app/pages/admin_home_page.dart';
import 'package:blog_app/pages/user_or_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/admin_repository.dart';

class AdminLoginStatus extends StatelessWidget {
  const AdminLoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminBloc(hiveDatabase: AdminAuthBox())..add(CheckAdminAuthStatus()),
      child: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) async {
          if (state is AdminLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
            );
          } else if (state is AdminInitial || state is AdminLoginFailure) {
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
