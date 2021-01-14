part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserModel user;

  Authenticated(this.user);
  
}

class UnAuthenticated extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthError extends AuthenticationState {}