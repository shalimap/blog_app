part of 'admin_bloc.dart';

sealed class AdminEvent {}

class AdminLoginRequested extends AdminEvent {
  final String email;
  final String password;

  AdminLoginRequested({required this.email, required this.password});
}

class CheckAdminAuthStatus extends AdminEvent {}

class AdminLogoutRequested extends AdminEvent {}
