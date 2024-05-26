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

final class FetchDetailPostWithoutLoading extends DetailPostEvent {
  final String id;

  const FetchDetailPostWithoutLoading(this.id);

  @override
  List<Object> get props => [id];
}

final class VoteDetailPost extends DetailPostEvent {
  final int vote;

  const VoteDetailPost(this.vote);

  @override
  List<Object> get props => [vote];
}

final class RemoveVoteDetailPost extends DetailPostEvent {
  const RemoveVoteDetailPost();

  @override
  List<Object> get props => [];
}

final class SaveDetailPost extends DetailPostEvent {
  final bool save;

  const SaveDetailPost({required this.save});

  @override
  List<Object> get props => [save];
  
}
