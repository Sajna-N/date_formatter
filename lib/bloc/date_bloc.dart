import 'package:bloc/bloc.dart';
import 'package:dob_task/bloc/date_event.dart';
import 'package:dob_task/bloc/date_state.dart';

class DobBloc extends Bloc<DobEvent, DobState> {
  DobBloc() : super(DobState(dateFormatted: ''));

  Stream<DobState> mapEventToState(DobEvent event) async* {
    if (event is DobDateChanged) {
      yield DobState(dateFormatted: event.date);
    }
  }
}
