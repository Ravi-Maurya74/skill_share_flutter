import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';
import 'package:skill_share/data/models/community.dart';

part 'community_list_event.dart';
part 'community_list_state.dart';

class CommunityListBloc extends Bloc<CommunityListEvent, CommunityListState> {
  CommunityListBloc() : super(CommunityListInitial()) {
    on<FetchCommunityList>(_onFetchCommunityList);
    add(FetchCommunityList());
  }
  void _onFetchCommunityList(
      FetchCommunityList event, Emitter<CommunityListState> emit) async {
    emit(CommunityListLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      Response response = await Dio().get(
        CommunityApiConstants.listCreateCommunity,
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      List<Community> communities = (response.data as List)
          .map((community) => Community.fromMap(community))
          .toList();
      emit(CommunityListLoaded(communities));
    } catch (error) {
      emit(CommunityListError(error.toString()));
    }
  }
}
