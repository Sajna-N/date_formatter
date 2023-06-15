// import 'package:dob_task/bloc/date_event.dart';
// import 'package:dob_task/bloc/date_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// class DobBloc extends Bloc<DobEvent, DobState> {
//   final TextEditingController controller = TextEditingController();
//   final DateFormat formatter = DateFormat('dd/MM/yyyy');

//   DobBloc() : super(InitialDobState());

//   @override
//   Stream<DobState> mapEventToState(DobEvent event) async* {
//     if (event is UpdateSelectedDateEvent) {
//       yield DobState(event.selectedDate);
//       controller.text = formatter.format(event.selectedDate);
//     }
//   }

//   @override
//   Future<void> close() {
//     controller.dispose();
//     return super.close();
//   }
// }

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

// class DobBloc extends Bloc<DobEvent, DobState> {
//   DobBloc() : super(const DobState(dateFormatted: '')) {
//     on<DobDateChanged>((event, emit) {
//       emit(DobState(dateFormatted: event.date));
//     });
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:dob_task/bloc/date_event.dart';
// import 'package:dob_task/bloc/date_state.dart';

// class DobBloc extends Bloc<DobEvent, DobState> {
//   DobBloc() : super(DobState(dateFormatted: '')) {
//     on<DobDateChanged>(_onDobDateChanged);
//   }

//   void _onDobDateChanged(DobDateChanged event, Emitter<DobState> emit) {
//     emit(state.copyWith(dateFormatted: event.date));
//   }

//   // void _onDobDateChanged(DobDateChanged event, Emitter<DobState> emit) {
//   //   emit(DobState(dateFormatted: event.date));
//   // }
// }
