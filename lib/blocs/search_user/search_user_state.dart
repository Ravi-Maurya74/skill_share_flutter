part of 'search_user_bloc.dart';

sealed class SearchUserState extends Equatable {
  const SearchUserState();
  
  @override
  List<Object> get props => [];
}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserLoading extends SearchUserState {}

final class SearchUserSuccess extends SearchUserState {
  final List<User> users;

  const SearchUserSuccess(this.users);

  @override
  List<Object> get props => [users];
}

final class SearchUserError extends SearchUserState {
  final String message;

  const SearchUserError(this.message);

  @override
  List<Object> get props => [message];
}
