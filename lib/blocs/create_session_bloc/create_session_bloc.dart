import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/list_session.dart';

part 'create_session_event.dart';
part 'create_session_state.dart';

class CreateSessionBloc extends Bloc<CreateSessionEvent, CreateSessionState> {
  CreateSessionBloc() : super(CreateSessionInitial()) {
    on<CreateSessionStarted>(_onCreateSessionStarted);
  }
  void _onCreateSessionStarted(
      CreateSessionStarted event, Emitter<CreateSessionState> emit) async {
    emit(CreateSessionLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      final Response response = await Dio().post(
        SessionApiConstants.listCreateSession,
        data: {
          "time": event.time,
          "community": event.community,
          "title": event.title,
          "description": event.description,
          "duration": event.duration
        },
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      emit(const CreateSessionLoaded());
    } catch (e) {
      emit(CreateSessionError(e.toString()));
    }
  }
}
