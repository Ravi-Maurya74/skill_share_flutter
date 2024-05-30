import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/comment.dart';

part 'create_comment_event.dart';
part 'create_comment_state.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  CreateCommentBloc() : super(CreateCommentInitial()) {
    on<CreateComment>(_onCreateComment);
  }
  Future<void> _onCreateComment(CreateComment event, Emitter<CreateCommentState> emit) async {
    emit(CreateCommentLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      final Response response = await Dio().post(
        PostApiConstants.listCreateComments,
        data: {
          'post': event.post,
          'content': event.content,
          if (event.parent != null) 'parent': event.parent,
        },
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      final Comment comment = Comment.fromMap(response.data);
      emit(CreateCommentSuccess(comment));
    } catch (e) {
      emit(const CreateCommentFailure('Failed to create comment'));
    }
  }
}
