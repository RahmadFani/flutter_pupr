part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthIsStart extends AuthenticationEvent {}

class AuthLogout extends AuthenticationEvent {}

class AuthLogin extends AuthenticationEvent {
  final String username;
  final String password;

  AuthLogin({this.username, this.password});

}
