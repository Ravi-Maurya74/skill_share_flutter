part of 'user_posts_bloc.dart';

sealed class UserPostsEvent extends Equatable {
  const UserPostsEvent();

  @override
  List<Object> get props => [];
}

final class UserPostsFetch extends UserPostsEvent {

  const UserPostsFetch();

  @override
  List<Object> get props => [];
}
