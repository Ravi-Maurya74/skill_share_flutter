part of 'create_comment_bloc.dart';

sealed class CreateCommentEvent extends Equatable {
  const CreateCommentEvent();

  @override
  List<Object> get props => [];
}

final class CreateComment extends CreateCommentEvent {
  final int post;
  final String content;
  final int? parent;

  const CreateComment({required this.post,required this.content,this.parent});

  @override
  List<Object> get props => [post, content];
}
