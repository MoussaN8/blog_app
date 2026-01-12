part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class  AuthSignUpEvent extends AuthEvent{
   final String email;
  final String name;
  final String password;

  AuthSignUpEvent({required this.email, required this.name, required this.password});
}
final class  AuthLogInEvent extends AuthEvent{
   final String email;
  final String password;

  AuthLogInEvent({required this.email, required this.password});
}

final class AuthIsUserLogIn extends AuthEvent{}
