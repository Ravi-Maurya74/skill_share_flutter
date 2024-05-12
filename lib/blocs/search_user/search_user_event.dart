part of 'search_user_bloc.dart';

sealed class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

final class SearchEvent extends SearchUserEvent {
  final String query;

  const SearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
