part of 'community_list_bloc.dart';

sealed class CommunityListState extends Equatable {
  const CommunityListState();
  
  @override
  List<Object> get props => [];
}

final class CommunityListInitial extends CommunityListState {}

final class CommunityListLoading extends CommunityListState {}

final class CommunityListLoaded extends CommunityListState {
  final List<Community> communities;

  const CommunityListLoaded(this.communities);

  @override
  List<Object> get props => [communities];
}

final class CommunityListError extends CommunityListState {
  final String message;

  const CommunityListError(this.message);

  @override
  List<Object> get props => [message];
}
