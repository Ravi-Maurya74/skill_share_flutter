part of 'create_comment_bloc.dart';

sealed class CreateCommentState extends Equatable {
  const CreateCommentState();
  
  @override
  List<Object> get props => [];
}

final class CreateCommentInitial extends CreateCommentState {}

final class CreateCommentLoading extends CreateCommentState {}

final class CreateCommentSuccess extends CreateCommentState {
  final Comment comment;

  const CreateCommentSuccess(this.comment);

  @override
  List<Object> get props => [comment];
}

final class CreateCommentFailure extends CreateCommentState {
  final String message;

  const CreateCommentFailure(this.message);

  @override
  List<Object> get props => [message];
}
