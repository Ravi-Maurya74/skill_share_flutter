part of 'detail_post_bloc.dart';

sealed class DetailPostEvent extends Equatable {
  const DetailPostEvent();

  @override
  List<Object> get props => [];
}

final class FetchDetailPost extends DetailPostEvent {
  final String id;

  const FetchDetailPost(this.id);

  @override
  List<Object> get props => [id];
}
