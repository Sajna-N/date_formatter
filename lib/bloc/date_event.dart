// abstract class DobEvent {}

// class UpdateSelectedDateEvent extends DobEvent {
//   final DateTime selectedDate;

//   UpdateSelectedDateEvent(this.selectedDate);
// }

abstract class DobEvent {}

class DobDateChanged extends DobEvent {
  final String date;

  DobDateChanged({required this.date});
}

// import 'package:equatable/equatable.dart';

// abstract class DobEvent extends Equatable {
//   const DobEvent();

//   @override
//   List<Object?> get props => [];
// }

// class DobDateChanged extends DobEvent {
//   final String date;

//   const DobDateChanged({required this.date});

//   @override
//   List<Object?> get props => [date];
// }
