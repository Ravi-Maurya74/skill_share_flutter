part of 'list_feedback_bloc.dart';

sealed class ListFeedbackEvent extends Equatable {
  const ListFeedbackEvent();

  @override
  List<Object> get props => [];
}

final class ListFeedbackStarted extends ListFeedbackEvent {
  final String sessionId;

  const ListFeedbackStarted(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}
