part of 'create_community_bloc.dart';

sealed class CreateCommunityState extends Equatable {
  const CreateCommunityState();
  
  @override
  List<Object> get props => [];
}

final class CreateCommunityInitial extends CreateCommunityState {}

final class CreateCommunityLoading extends CreateCommunityState {}

final class CreateCommunitySuccess extends CreateCommunityState {
  final dynamic community;

  const CreateCommunitySuccess(this.community);

  @override
  List<Object> get props => [community];
}

final class CreateCommunityError extends CreateCommunityState {
  final String message;

  const CreateCommunityError(this.message);

  @override
  List<Object> get props => [message];
}
