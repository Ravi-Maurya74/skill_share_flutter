part of 'all_dms_bloc.dart';

sealed class AllDmsState extends Equatable {
  const AllDmsState();
  
  @override
  List<Object> get props => [];
}

final class AllDmsInitial extends AllDmsState {}

final class AllDmsLoading extends AllDmsState {}

final class AllDmsLoaded extends AllDmsState {
  final List<Chat> dms;

  const AllDmsLoaded(this.dms);

  @override
  List<Object> get props => [dms];
}

final class AllDmsError extends AllDmsState {
  final String message;

  const AllDmsError(this.message);

  @override
  List<Object> get props => [message];
}
