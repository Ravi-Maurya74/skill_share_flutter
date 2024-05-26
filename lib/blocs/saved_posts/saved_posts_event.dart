part of 'saved_posts_bloc.dart';

sealed class SavedPostsEvent extends Equatable {
  const SavedPostsEvent();

  @override
  List<Object> get props => [];
}

final class GetSavedPosts extends SavedPostsEvent {}
