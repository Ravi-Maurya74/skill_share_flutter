part of 'create_community_bloc.dart';

sealed class CreateCommunityEvent extends Equatable {
  const CreateCommunityEvent();

  @override
  List<Object> get props => [];
}

final class CreateCommunityRequest extends CreateCommunityEvent {
  final String name;
  final String description;
  final File banner;
  final File profile_image;
  final int skill;

  const CreateCommunityRequest({required this.name,required this.description,required this.banner,required this.profile_image,required this.skill});

  @override
  List<Object> get props => [name, description, banner, profile_image, skill];
}
