import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/list_feedback.dart';
import 'package:skill_share/data/models/list_session.dart';

part 'list_feedback_event.dart';
part 'list_feedback_state.dart';

class ListFeedbackBloc extends Bloc<ListFeedbackEvent, ListFeedbackState> {
  ListFeedbackBloc(this.listSession) : super(ListFeedbackInitial()) {
    on<ListFeedbackStarted>(_onListFeedbackStarted);
    add(ListFeedbackStarted(listSession.id.toString()));
  }
  final ListSession listSession;
  void _onListFeedbackStarted(
      ListFeedbackStarted event, Emitter<ListFeedbackState> emit) async {
    emit(ListFeedbackLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      final Response response = await Dio().get(
        FeedbackApiConstants.listCreateFeedback,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
        queryParameters: {
          'session': event.sessionId,
        },
      );
      List<ListFeedback> feedbacks = (response.data as List)
          .map((feedback) => ListFeedback.fromMap(feedback))
          .toList();
      print(feedbacks);
      emit(ListFeedbackLoaded(feedbacks));
    } catch (e) {
      emit(ListFeedbackError(e.toString()));
    }
  }
}
