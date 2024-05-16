import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/detail_post.dart';

part 'detail_post_event.dart';
part 'detail_post_state.dart';

class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  DetailPostBloc() : super(DetailPostInitial()) {
    on<FetchDetailPost>(_onFetchDetailPost);
  }
  void _onFetchDetailPost(
      FetchDetailPost event, Emitter<DetailPostState> emit) async {
    emit(DetailPostLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      Response response = await Dio().get(
        PostApiConstants.listCreatePost + event.id,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      DetailPost post = DetailPost.fromMap(response.data);
      emit(DetailPostLoaded(post));
    } catch (error) {
      emit(DetailPostError(error.toString()));
    }
  }
}
