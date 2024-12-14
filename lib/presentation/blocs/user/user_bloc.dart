import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launder_app/models/user.dart';
import 'package:launder_app/presentation/blocs/user/user_event.dart';
import 'package:launder_app/presentation/blocs/user/user_state.dart';
import 'package:launder_app/services/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc({required this.userService}) : super(UserInitial()) {
    on<UserRegisterEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userService.register(RegisterUserRequest(
            name: event.name,
            username: event.username,
            email: event.email,
            phone: event.phone,
            password: event.password
        ));
        emit(const UserRegister(message: 'User registered successfully'));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserLoginEvent>((event, emit) async {
      emit(UserLoading());
      try {
        await userService.login(LoginUserRequest(
            username: event.username,
            password: event.password
        ));
        emit(const UserLogin(message: 'User logged in successfully'));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserGetEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userService.get();
        emit(UserSuccess(message: 'User success get data user', data: user));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserUpdateEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userService.update(UpdateUserRequest(
            name: event.name,
            username: event.username,
            email: event.email,
            phone: event.phone
        ));
        emit(UserSuccess(message: 'User success update data user', data: user));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });

    on<UserLogoutEvent>((event, emit) async {
      emit(UserLoading());
      try {
        await userService.logout();
        emit(const UserLogout(message: 'User logout is successfully'));
      } catch (e) {
        emit(UserFailure(message: e.toString()));
      }
    });
  }
}