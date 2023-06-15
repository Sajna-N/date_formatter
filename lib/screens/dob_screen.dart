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
