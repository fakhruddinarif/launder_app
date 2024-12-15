import 'package:equatable/equatable.dart';
import 'package:launder_app/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoginSuccess extends UserState {
  final String message;

  const UserLoginSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class UserRegisterSuccess extends UserState {
  final String message;

  const UserRegisterSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class UserLogoutSuccess extends UserState {
  final String message;

  const UserLogoutSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class UserSuccess<T> extends UserState {
  final String message;
  final T data;

  const UserSuccess({required this.message, required this.data});

  @override
  List<Object> get props => [message, if (data is Object) data as Object else data.toString()];
}

class UserFailure extends UserState {
  final String message;

  const UserFailure({required this.message});

  @override
  List<Object> get props => [message];
}