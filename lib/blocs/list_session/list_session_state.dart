part of 'list_session_bloc.dart';

sealed class ListSessionState extends Equatable {
  const ListSessionState();
  
  @override
  List<Object> get props => [];
}

final class ListSessionInitial extends ListSessionState {}

final class ListSessionLoading extends ListSessionState {}

final class ListSessionLoaded extends ListSessionState {
  final List<ListSession> sessions;

  const ListSessionLoaded(this.sessions);

  @override
  List<Object> get props => [sessions];
}

final class ListSessionError extends ListSessionState {
  final String message;

  const ListSessionError(this.message);

  @override
  List<Object> get props => [message];
}