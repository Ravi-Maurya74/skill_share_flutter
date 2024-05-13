part of 'all_dms_bloc.dart';

sealed class AllDmsEvent extends Equatable {
  const AllDmsEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllDms extends AllDmsEvent {}
