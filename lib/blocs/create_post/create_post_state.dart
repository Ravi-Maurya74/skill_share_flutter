part of 'create_post_bloc.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();
  
  @override
  List<Object> get props => [];
}

final class CreatePostInitial extends CreatePostState {}

final class CreatePostLoading extends CreatePostState {}

final class CreatePostSuccess extends CreatePostState {
  final dynamic post;

  const CreatePostSuccess(this.post);

  @override
  List<Object> get props => [post];
}

final class CreatePostError extends CreatePostState {
  final String message;

  const CreatePostError(this.message);

  @override
  List<Object> get props => [message];
}
