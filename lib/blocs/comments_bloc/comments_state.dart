part of 'comments_bloc.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();
  
  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class CommentsLoaded extends CommentsState {
  final List<Comment> comments;

  const CommentsLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}

final class CommentsError extends CommentsState {
  final String error;

  const CommentsError(this.error);

  @override
  List<Object> get props => [error];
}
