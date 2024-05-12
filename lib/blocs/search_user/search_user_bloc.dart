import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/user.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc() : super(SearchUserInitial()) {
    on<SearchEvent>(_onSearchUserEvent);
  }
  void _onSearchUserEvent(
      SearchEvent event, Emitter<SearchUserState> emit) async {
    emit(SearchUserLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      Response response = await Dio().get(
        UserApiConstants.searchUser,
        queryParameters: {
          'query': event.query,
        },
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      List<User> users =
          (response.data as List).map((user) => User.fromMap(user)).toList();
      emit(SearchUserSuccess(users));
    } catch (error) {
      emit(SearchUserError(error.toString()));
    }
  }
}
