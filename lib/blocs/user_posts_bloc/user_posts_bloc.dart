import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/list_post.dart';

part 'user_posts_event.dart';
part 'user_posts_state.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {
  UserPostsBloc() : super(UserPostsInitial()) {
    on<UserPostsFetch>(_onUserPostsFetch);
    add(const UserPostsFetch());
  }
  void _onUserPostsFetch(UserPostsFetch event, Emitter<UserPostsState> emit) async{
  emit(UserPostsLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      final Response response = await Dio().get(
        PostApiConstants.userPosts,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      final List<ListPost> posts =
          (response.data as List).map((post) => ListPost.fromMap(post)).toList();
      emit(UserPostsLoaded(posts));
    } catch (e) {
      emit(const UserPostsError('Failed to load saved posts'));
    }
  }
}
