import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:skill_share/data/services/user_service.dart';
import 'package:skill_share/data/models/user.dart' as MyUser;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.userService}) : super(Unauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<LogOut>(_onLogOut);
  }
  final UserService userService;

  void _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    MyUser.User user = await userService.signIn();
    emit(Authenticated(user));
  }

  void _onLogOut(LogOut event, Emitter<AuthenticationState> emit) async {
    await userService.signOut();
    emit(Unauthenticated());
  }
}
