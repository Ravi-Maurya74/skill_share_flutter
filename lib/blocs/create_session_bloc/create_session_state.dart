part of 'create_session_bloc.dart';

sealed class CreateSessionState extends Equatable {
  const CreateSessionState();
  
  @override
  List<Object> get props => [];
}

final class CreateSessionInitial extends CreateSessionState {}

final class CreateSessionLoading extends CreateSessionState {}

final class CreateSessionLoaded extends CreateSessionState {

  const CreateSessionLoaded();

  @override
  List<Object> get props => [];
}

final class CreateSessionError extends CreateSessionState {
  final String message;

  const CreateSessionError(this.message);

  @override
  List<Object> get props => [message];
}
