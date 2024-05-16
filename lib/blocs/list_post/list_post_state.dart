part of 'list_post_bloc.dart';

sealed class ListPostState extends Equatable {
  const ListPostState();
  
  @override
  List<Object> get props => [];
}

final class ListPostInitial extends ListPostState {}

final class ListPostLoading extends ListPostState {}

final class ListPostLoaded extends ListPostState {
  final List<ListPost> posts;

  const ListPostLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class ListPostError extends ListPostState {
  final String message;

  const ListPostError(this.message);

  @override
  List<Object> get props => [message];
}
