import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/list_post.dart';

part 'saved_posts_event.dart';
part 'saved_posts_state.dart';

class SavedPostsBloc extends Bloc<SavedPostsEvent, SavedPostsState> {
  SavedPostsBloc() : super(SavedPostsInitial()) {
    on<GetSavedPosts>(_onGetSavedPosts);
    add(GetSavedPosts());
  }
  Future<void> _onGetSavedPosts(GetSavedPosts event, Emitter<SavedPostsState> emit) async {
    emit(SavedPostsLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      final Response response = await Dio().get(
        PostApiConstants.savedPosts,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      final List<ListPost> posts =
          (response.data as List).map((post) => ListPost.fromMap(post)).toList();
      emit(SavedPostsLoaded(posts));
    } catch (e) {
      emit(const SavedPostsError('Failed to load saved posts'));
    }
  }
}
