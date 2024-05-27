part of 'comments_bloc.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

final class CommentsFetch extends CommentsEvent {
  final int post;
  final int? parent;

  const CommentsFetch({required this.post,this.parent});
  
}
