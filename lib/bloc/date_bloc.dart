import 'package:bloc/bloc.dart';
import 'package:dob_task/bloc/date_event.dart';
import 'package:dob_task/bloc/date_state.dart';

class DobBloc extends Bloc<DobEvent, DobState> {
  // DobBloc() : super(DobState(dateFormatted: ''));

  DobBloc() : super(DobState(dateFormatted: '')) {
    on<DobDateChanged>((event, emit) async* {
      emit(DobState(dateFormatted: event.date));
    });
  }
}
