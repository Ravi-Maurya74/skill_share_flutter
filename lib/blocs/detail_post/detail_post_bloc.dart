import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/detail_post.dart';

part 'detail_post_event.dart';
part 'detail_post_state.dart';

class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  DetailPostBloc(this.id) : super(DetailPostInitial()) {
    on<FetchDetailPost>(_onFetchDetailPost);
    on<VoteDetailPost>(_onVoteDetailPost);
    on<SaveDetailPost>(_onSaveDetailPost);
    on<FetchDetailPostWithoutLoading>(_onFetchDetailPostWithoutLoading);
    on<RemoveVoteDetailPost>(_onRemoveVoteDetailPost);
    add(FetchDetailPost(id));
  }

  final String id;

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

  void _onFetchDetailPostWithoutLoading(FetchDetailPostWithoutLoading event,
      Emitter<DetailPostState> emit) async {
    // emit(DetailPostLoading());
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

  void _onVoteDetailPost(
      VoteDetailPost event, Emitter<DetailPostState> emit) async {
    DetailPost currentState = (state as DetailPostLoaded).post;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
    try {

      // Optimistic UI update
      DetailPost updatedPost = currentState.copyWith(
        upvotes:
            event.vote == 1 ? currentState.upvotes + 1 : currentState.upvotes,
        downvotes: event.vote == -1
            ? currentState.downvotes + 1
            : currentState.downvotes,
        score: currentState.score + event.vote,
        vote: event.vote,
      );
      emit(DetailPostLoaded(updatedPost));
      Response response = await Dio().post(
        PostApiConstants.votePost,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
        data: {
          'post': id,
          'value': event.vote,
        },
      );
      // DetailPost post = DetailPost.fromMap(response.data);
      // emit(DetailPostLoaded(post));
      add(FetchDetailPostWithoutLoading(id));
    } catch (error) {
      emit(DetailPostLoaded(currentState));
    }
  }

  void _onSaveDetailPost(
      SaveDetailPost event, Emitter<DetailPostState> emit) async {
    DetailPost currentState = (state as DetailPostLoaded).post;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;

      // Optimistic UI update
      DetailPost updatedPost = currentState.copyWith(
        is_saved: event.save,
      );
      emit(DetailPostLoaded(updatedPost));
      Response response = await Dio().post(
        PostApiConstants.savePost,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
        data: {
          'post': id,
          'save': event.save,
        },
      );
      add(FetchDetailPostWithoutLoading(id));
    } catch (error) {
      emit(DetailPostLoaded(currentState));
    }
  }

  void _onRemoveVoteDetailPost(
      RemoveVoteDetailPost event, Emitter<DetailPostState> emit) async {
    DetailPost currentState = (state as DetailPostLoaded).post;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      // Optimistic UI update
      DetailPost updatedPost = currentState.copyWith(
        upvotes: currentState.vote! == 1
            ? currentState.upvotes - 1
            : currentState.upvotes,
        downvotes: currentState.vote! == -1
            ? currentState.downvotes - 1
            : currentState.downvotes,
        score: currentState.score - currentState.vote!,
        vote: null,
      );
      emit(DetailPostLoaded(updatedPost));
      await Dio().post(
        PostApiConstants.votePost,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
        data: {
          'post': id,
          'value': 0,
        },
      );
      add(FetchDetailPostWithoutLoading(id));
    } catch (error) {
      emit(DetailPostLoaded(currentState));
    }
  }
}
