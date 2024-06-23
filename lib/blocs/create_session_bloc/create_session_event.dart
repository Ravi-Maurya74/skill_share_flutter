part of 'create_session_bloc.dart';

sealed class CreateSessionEvent extends Equatable {
  const CreateSessionEvent();

  @override
  List<Object> get props => [];
}

final class CreateSessionStarted extends CreateSessionEvent {
  final String community;
  final String title;
  final String description;
  final String time;
  final int duration;

  const CreateSessionStarted(this.community, this.title, this.description, this.time,this.duration);

  @override
  List<Object> get props => [community,title,description,time];
}
