part of 'list_post_bloc.dart';

sealed class ListPostEvent extends Equatable {
  const ListPostEvent();

  @override
  List<Object> get props => [];
}

final class FetchListPost extends ListPostEvent {
  final String? query;

  const FetchListPost(this.query);

  @override
  List<Object> get props => [];
}
