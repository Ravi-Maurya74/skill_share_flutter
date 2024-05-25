part of 'list_session_bloc.dart';

sealed class ListSessionEvent extends Equatable {
  const ListSessionEvent();

  @override
  List<Object> get props => [];
}

final class ListSessionFetch extends ListSessionEvent {
  final String community;

  const ListSessionFetch(this.community);

  @override
  List<Object> get props => [community];
}
