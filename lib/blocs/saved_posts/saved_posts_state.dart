part of 'saved_posts_bloc.dart';

sealed class SavedPostsState extends Equatable {
  const SavedPostsState();
  
  @override
  List<Object> get props => [];
}

final class SavedPostsInitial extends SavedPostsState {}

final class SavedPostsLoading extends SavedPostsState {}

final class SavedPostsLoaded extends SavedPostsState {
  final List<ListPost> posts;

  const SavedPostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class SavedPostsError extends SavedPostsState {
  final String message;

  const SavedPostsError(this.message);

  @override
  List<Object> get props => [message];
}
