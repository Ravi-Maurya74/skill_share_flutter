part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {}

final class LogIn extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

final class LogOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
