part of 'community_list_bloc.dart';

sealed class CommunityListEvent extends Equatable {
  const CommunityListEvent();

  @override
  List<Object> get props => [];
}

final class FetchCommunityList extends CommunityListEvent {}

final class AddUserToCommunity extends CommunityListEvent {
  final int index;

  const AddUserToCommunity(this.index);

  @override
  List<Object> get props => [index];
}
