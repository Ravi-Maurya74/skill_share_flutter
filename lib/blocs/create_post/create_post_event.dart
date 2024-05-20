part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

final class CreatePostRequest extends CreatePostEvent {
  final String title;
  final String content;
  final String community;
  final File? image;

  const CreatePostRequest({required this.title,required this.content,required this.community, this.image});

  @override
  List<Object> get props => [title, content, community];
}
