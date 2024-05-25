import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/list_session.dart';

part 'list_session_event.dart';
part 'list_session_state.dart';

class ListSessionBloc extends Bloc<ListSessionEvent, ListSessionState> {
  ListSessionBloc(this.community) : super(ListSessionInitial()) {
    on<ListSessionFetch>(_onListSessionFetch);
    add(ListSessionFetch(community));
  }
  final String community ;
  void _onListSessionFetch(
      ListSessionFetch event, Emitter<ListSessionState> emit) async {
    emit(ListSessionLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      final Response response = await Dio().get(
        SessionApiConstants.listCreateSession,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
        queryParameters: {
          'community': community,
        },
      );
      final List<ListSession> sessions =
          (response.data as List).map((session) => ListSession.fromMap(session)).toList();
      emit(ListSessionLoaded(sessions));
    } catch (error) {
      emit(ListSessionError(error.toString()));
    }
  }
}
