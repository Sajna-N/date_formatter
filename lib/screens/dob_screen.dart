// import 'package:dob_task/widgets/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DobScreen extends StatefulWidget {
//   const DobScreen({super.key});

//   @override
//   _DobScreenState createState() => _DobScreenState();
// }

// class _DobScreenState extends State<DobScreen> {
//   late TextEditingController _controller;
//   String _formattedDate = '';

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     _controller.addListener(_updateFormattedDate);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _updateFormattedDate() {
//     setState(() {
//       final inputDate = _parseDate(_controller.text);
//       if (inputDate != null) {
//         _formattedDate = DateFormat('dd/MM/yyyy').format(inputDate);
//       } else {
//         _formattedDate = '';
//       }
//     });
//   }

//   DateTime? _parseDate(String input) {
//     final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
//     try {
//       return inputFormat.parse(input);
//     } catch (e) {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter your Details'),
//       ),
//       body: Column(
//         children: <Widget>[
//           const SizedBox(
//             height: 100,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Stack(
//               alignment: Alignment.centerLeft,
//               children: [
//                 Text(_formattedDate),
//                 TextField(
//                   controller: _controller,
//                   keyboardType: TextInputType.datetime,
//                   inputFormatters: [DateFormatter()],
//                   decoration: InputDecoration(
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                     suffixIcon: IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.calendar_today),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:dob_task/widgets/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DobScreen extends StatefulWidget {
//   const DobScreen({super.key});

//   @override
//   State<DobScreen> createState() => _DobScreenState();
// }

// class _DobScreenState extends State<DobScreen> {
//   final TextEditingController _controller = TextEditingController();
//   DateTime _selectedDate = DateTime.now();

//   final DateFormatter _dateFormatter = DateFormatter();

//   void _presentDatePicker() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2019),
//       lastDate: DateTime.now(),
//     ).then((pickedDate) {
//       if (pickedDate == null) {
//         return;
//       }
//       setState(() {
//         _selectedDate = pickedDate;
//         _controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
//       });
//     });
//   }

//   Text _changingData() {
//     return Text(
//       ' ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
//       style: const TextStyle(color: Colors.black),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter your Details'),
//       ),
//       body: Column(
//         children: <Widget>[
//           const SizedBox(
//             height: 100,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Stack(
//               alignment: Alignment.centerLeft,
//               children: [
//                 ValueListenableBuilder(
//                     valueListenable: _controller,
//                     builder: (context, snapshot, _) {
//                       // return Text(generateDateFormat("DD/MM/YYYY"));
//                       // return Text(generateDateFormat(_controller.text));
//                       return Text(
//                         _dateFormatter.generateDateFormat(_controller.text),
//                         style: const TextStyle(color: Colors.grey),
//                       );
//                     }),
//                 TextField(
//                   controller: _controller,
//                   keyboardType: TextInputType.datetime,
//                   inputFormatters: [DateFormatter()],
//                   style: const TextStyle(color: Colors.black),
//                   onChanged: (text) {
//                     _changingData();
//                     // Handle the updated text here
//                     // You can access the formatted date from _formatSelectedDate()
//                     print(_changingData());
//                   },
//                   decoration: InputDecoration(
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     suffixIcon: IconButton(
//                       onPressed: _presentDatePicker,
//                       icon: const Icon(Icons.calendar_today),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:dob_task/bloc/date_bloc.dart';
import 'package:dob_task/bloc/date_event.dart';
import 'package:dob_task/bloc/date_state.dart';
import 'package:dob_task/widgets/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DobScreen extends StatelessWidget {
  const DobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your Details'),
      ),
      body: BlocProvider(
        create: (context) => DobBloc(),
        child: BlocBuilder<DobBloc, DobState>(
          builder: (context, state) {
            final TextEditingController controller = TextEditingController();
            final DateFormatter dateFormatter = DateFormatter();

            void presentDatePicker() {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime.now(),
              ).then((pickedDate) {
                if (pickedDate == null) {
                  return;
                }
                final formattedDate =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                controller.text = formattedDate;
                BlocProvider.of<DobBloc>(context)
                    .add(DobDateChanged(date: formattedDate));
              });
            }

            return Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: controller,
                        builder: (context, snapshot, _) {
                          return Text(
                            dateFormatter.generateDateFormat(controller.text),
                            style: const TextStyle(color: Colors.grey),
                          );
                        },
                      ),
                      TextField(
                        controller: controller,
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [DateFormatter()],
                        onChanged: (text) {
                          BlocProvider.of<DobBloc>(context)
                              .add(DobDateChanged(date: text));
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: presentDatePicker,
                            icon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   state.date,
                //   style: const TextStyle(color: Colors.black),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// class DobScreen extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();

//   DobScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter your Details'),
//       ),
//       body: BlocBuilder<DobBloc, DobState>(
//         builder: (context, state) {
//           return Column(
//             children: <Widget>[
//               const SizedBox(
//                 height: 100,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Stack(
//                   alignment: Alignment.centerLeft,
//                   children: [
//                     Text(
//                       state.dateFormatted,
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                     TextField(
//                       controller: _controller,
//                       keyboardType: TextInputType.datetime,
//                       inputFormatters: [DateFormatter()],
//                       onChanged: (text) {
//                         BlocProvider.of<DobBloc>(context)
//                             .add(DobDateChanged(date: text));
//                       },
//                       decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2019),
//                               lastDate: DateTime.now(),
//                             ).then((pickedDate) {
//                               if (pickedDate != null) {
//                                 final formattedDate =
//                                     DateFormat('dd/MM/yyyy').format(pickedDate);
//                                 _controller.text = formattedDate;
//                                 BlocProvider.of<DobBloc>(context)
//                                     .add(DobDateChanged(date: formattedDate));
//                               }
//                             });
//                           },
//                           icon: const Icon(Icons.calendar_today),
//                         ),
//                       ),
//                     ),
//                     // TextField(
//                     //   controller: _controller,
//                     //   keyboardType: TextInputType.datetime,
//                     //   onChanged: (text) {
//                     //     BlocProvider.of<DobBloc>(context)
//                     //         .add(DobDateChanged(date: text));
//                     //   },
//                     //   decoration: InputDecoration(
//                     //     suffixIcon: IconButton(
//                     //       onPressed: () {
//                     //         showDatePicker(
//                     //           context: context,
//                     //           initialDate: DateTime.now(),
//                     //           firstDate: DateTime(2019),
//                     //           lastDate: DateTime.now(),
//                     //         ).then((pickedDate) {
//                     //           if (pickedDate != null) {
//                     //             final formattedDate =
//                     //                 DateFormat('dd/MM/yyyy').format(pickedDate);
//                     //             _controller.text = formattedDate;
//                     //             BlocProvider.of<DobBloc>(context).add(
//                     //                 DobDateChanged(date: formattedDate));
//                     //           }
//                     //         });
//                     //       },
//                     //       icon: const Icon(Icons.calendar_today),
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
