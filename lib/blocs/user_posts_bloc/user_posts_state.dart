part of 'user_posts_bloc.dart';

sealed class UserPostsState extends Equatable {
  const UserPostsState();
  
  @override
  List<Object> get props => [];
}

final class UserPostsInitial extends UserPostsState {}

final class UserPostsLoading extends UserPostsState {}

final class UserPostsLoaded extends UserPostsState {
  final List<ListPost> posts;

  const UserPostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class UserPostsError extends UserPostsState {
  final String message;

  const UserPostsError(this.message);

  @override
  List<Object> get props => [message];
}
