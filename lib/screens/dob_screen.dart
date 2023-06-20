import 'package:dob_task/bloc/date_bloc.dart';
import 'package:dob_task/bloc/date_event.dart';
import 'package:dob_task/bloc/date_state.dart';
import 'package:dob_task/widgets/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DobScreen extends StatelessWidget {
  const DobScreen({Key? key}) : super(key: key);
  static List<TextInputFormatter> dob = <TextInputFormatter>[
    LengthLimitingTextInputFormatter(10),
    FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
    DateFormatter()
  ];
  static List<String> dateModal = [
    'D',
    'D',
    '/',
    'M',
    'M',
    '/',
    'Y',
    'Y',
    'Y',
    'Y'
  ];

  @override
  Widget build(BuildContext context) {
    print(dateModal.elementAt(4));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your Details'),
      ),
      body: BlocProvider(
        create: (context) => DobBloc(),
        child: BlocBuilder<DobBloc, DobState>(
          builder: (context, state) {
            final TextEditingController controller = TextEditingController();
            // TextEditingController textEditingController =
            //     TextEditingController();
            final DateFormatter dateFormatter = DateFormatter();
            print(controller.text.length);

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
                          return Row(
                            children: [
                              // Text(
                              //   controller.text,
                              //   style: const TextStyle(color: Colors.red),
                              // ),
                              Text(
                                dateFormatter
                                    .generateDateFormat(controller.text),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          );
                        },
                      ),
                      TextField(
                        controller: controller,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false),
                        inputFormatters: dob,
                        onChanged: (text) {
                          BlocProvider.of<DobBloc>(context)
                              .add(DobDateChanged(date: text));
                        },
                        style: const TextStyle(fontSize: 14),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
