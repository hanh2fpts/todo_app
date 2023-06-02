import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit() : super(const StatusState(complete: 0, active: 0));
   void getStatus(int complete, int active) {
    emit(StatusState(complete: complete, active: active));
  }
}
