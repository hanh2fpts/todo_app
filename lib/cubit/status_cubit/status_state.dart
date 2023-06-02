part of 'status_cubit.dart';

class StatusState extends Equatable {
  final int complete, active;

  const StatusState({required this.complete, required this.active});

  @override
  List<Object?> get props => [complete, active];
}
