part of 'detail_post_bloc.dart';

sealed class DetailPostState extends Equatable {
  const DetailPostState();
  
  @override
  List<Object> get props => [];
}

final class DetailPostInitial extends DetailPostState {}

final class DetailPostLoading extends DetailPostState {}

final class DetailPostLoaded extends DetailPostState {
  final DetailPost post;

  const DetailPostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

final class DetailPostError extends DetailPostState {
  final String message;

  const DetailPostError(this.message);

  @override
  List<Object> get props => [message];
}
