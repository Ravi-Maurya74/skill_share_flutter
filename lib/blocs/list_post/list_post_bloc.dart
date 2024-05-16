import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/list_post.dart';

part 'list_post_event.dart';
part 'list_post_state.dart';

class ListPostBloc extends Bloc<ListPostEvent, ListPostState> {
  ListPostBloc() : super(ListPostInitial()) {
    on<FetchListPost>(_onFetchListPost);
  }
  void _onFetchListPost(
      FetchListPost event, Emitter<ListPostState> emit) async {
    emit(ListPostLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      Response response = await Dio().get(
        PostApiConstants.listCreatePost,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
        queryParameters: {
          if (event.query != null)
          'query': event.query,
        },
      );
      List<ListPost> posts = (response.data as List)
          .map((community) => ListPost.fromMap(community))
          .toList();
      emit(ListPostLoaded(posts));
    } catch (error) {
      emit(ListPostError(error.toString()));
    }
  }
}
