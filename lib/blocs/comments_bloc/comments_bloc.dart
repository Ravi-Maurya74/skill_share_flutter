import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/comment.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc(this.post, this.parent) : super(CommentsInitial()) {
    on<CommentsFetch>(_onFetchComments);
    add(CommentsFetch(post: post, parent: parent));
  }
  final int post;
  final int? parent;

  Future<void> _onFetchComments(CommentsFetch event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      Response response = await Dio().get(
        PostApiConstants.comments,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
        queryParameters: {
          'post': event.post,
          if(event.parent != null)
          'parent': event.parent,
        },
      );
      List<Comment> comments = (response.data as List)
          .map((comment) => Comment.fromMap(comment))
          .toList();
      emit(CommentsLoaded(comments));
    } catch (error) {
      emit(CommentsError(error.toString()));
    }
  }
}
