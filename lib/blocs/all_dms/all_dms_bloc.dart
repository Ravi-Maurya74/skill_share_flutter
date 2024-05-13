import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/chat.dart';

part 'all_dms_event.dart';
part 'all_dms_state.dart';

class AllDmsBloc extends Bloc<AllDmsEvent, AllDmsState> {
  AllDmsBloc() : super(AllDmsInitial()) {
    on<FetchAllDms>(_onFetchAllDms);
    add(FetchAllDms());
  }
  void _onFetchAllDms(FetchAllDms event, Emitter<AllDmsState> emit) async {
    emit(AllDmsLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      Response response = await Dio().get(
        ChatApiConstants.listCreateChat,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      List<Chat> dms =
          (response.data as List).map((chat) => Chat.fromMap(chat)).toList();
      emit(AllDmsLoaded(dms));
    } catch (error) {
      emit(AllDmsError(error.toString()));
    }
  }
}
