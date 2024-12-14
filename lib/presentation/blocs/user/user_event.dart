import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserRegisterEvent extends UserEvent {
  final String name;
  final String username;
  final String email;
  final String password;
  final String phone;

  const UserRegisterEvent({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object> get props => [name, username, email, password, phone];
}

class UserLoginEvent extends UserEvent {
  final String username;
  final String password;

  const UserLoginEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class UserGetEvent extends UserEvent {}
class UserLogoutEvent extends UserEvent {}

class UserUpdateEvent extends UserEvent {
  final String name;
  final String username;
  final String email;
  final String phone;

  const UserUpdateEvent({
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
  });

  @override
  List<Object> get props => [name, username, email, phone];
}

class UserChangePasswordEvent extends UserEvent {
  final String oldPassword;
  final String newPassword;

  const UserChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword];
}