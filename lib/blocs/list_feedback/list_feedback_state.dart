part of 'list_feedback_bloc.dart';

sealed class ListFeedbackState extends Equatable {
  const ListFeedbackState();
  
  @override
  List<Object> get props => [];
}

final class ListFeedbackInitial extends ListFeedbackState {}

final class ListFeedbackLoading extends ListFeedbackState {}

final class ListFeedbackLoaded extends ListFeedbackState {
  final List<ListFeedback> feedbacks;

  const ListFeedbackLoaded(this.feedbacks);

  @override
  List<Object> get props => [feedbacks];
}

final class ListFeedbackError extends ListFeedbackState {
  final String message;

  const ListFeedbackError(this.message);

  @override
  List<Object> get props => [message];
}
