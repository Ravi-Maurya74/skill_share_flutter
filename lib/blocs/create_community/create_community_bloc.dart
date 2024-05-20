import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';

part 'create_community_event.dart';
part 'create_community_state.dart';

class CreateCommunityBloc
    extends Bloc<CreateCommunityEvent, CreateCommunityState> {
  CreateCommunityBloc() : super(CreateCommunityInitial()) {
    on<CreateCommunityRequest>(_onCreateCommunityRequest);
  }
  void _onCreateCommunityRequest(
      CreateCommunityRequest event, Emitter<CreateCommunityState> emit) async {
    emit(CreateCommunityLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      final Response response = await Dio().post(
        CommunityApiConstants.listCreateCommunity,
        data: FormData.fromMap({
          'name': event.name,
          'description': event.description,
          'banner': await MultipartFile.fromFile(event.banner.path),
          'profile_image':
              await MultipartFile.fromFile(event.profile_image.path),
          'skill': event.skill,
        }),
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      emit(CreateCommunitySuccess(response.data));
    } catch (error) {
      emit(CreateCommunityError(error.toString()));
    }
  }
}
