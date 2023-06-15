// class DobState {
//   final DateTime selectedDate;

//   DobState(this.selectedDate);
// }

// class InitialDobState extends DobState {
//   InitialDobState() : super(DateTime.now());
// }

// class DobState {
//   final String dateFormatted;

//   DobState({required this.dateFormatted});
// }

class DobState {
  final String dateFormatted;

  DobState({required this.dateFormatted});

  DobState copyWith({String? dateFormatted}) {
    return DobState(dateFormatted: dateFormatted ?? this.dateFormatted);
  }
}

// import 'package:equatable/equatable.dart';

// class DobState extends Equatable {
//   final String dateFormatted;

//   const DobState({required this.dateFormatted});

//   @override
//   List<Object?> get props => [dateFormatted];
// }
