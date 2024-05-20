import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/list_post.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(CreatePostInitial()) {
    on<CreatePostRequest>(_onCreatePost);
  }
  void _onCreatePost(
      CreatePostRequest event, Emitter<CreatePostState> emit) async {
    emit(CreatePostLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      final Response response = await Dio().post(
        PostApiConstants.listCreatePost,
        data: FormData.fromMap({
          'title': event.title,
          'content': event.content,
          'community': event.community,
          'image': event.image == null
              ? null
              : await MultipartFile.fromFile(event.image!.path),
        }),
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      emit(CreatePostSuccess(response.data));
    } catch (error) {
      emit(CreatePostError(error.toString()));
    }
  }
}
