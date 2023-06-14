import 'package:dob_task/widgets/date_format.dart';
import 'package:flutter/material.dart';

class DobScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  DobScreen({super.key});
  String generateDateFormat(String input) {
    print(_controller.text.length);
    int contollerLen = _controller.text.length;
    // final nonBreakingSpace = String.fromCharCode(160);
    int inputLength = input.length;
    print(inputLength);
    if (contollerLen == 0) {
      return "DD/MM/YYYY";
    } else if (contollerLen == 1) {
      return '     /MM/YYYY';
    } else if (contollerLen == 2) {
      return '     /MM/YYYY';
    } else if (contollerLen == 3) {
      return '       MM/YYYY';
    } else if (contollerLen == 4) {
      return '             /YYYY';
    } else if (contollerLen == 5) {
      return '             /YYYY';
    } else if (contollerLen == 6) {
      return '              YYYY';
    } else if (contollerLen == 7) {
      return '                    ';
    } else if (contollerLen == 8) {
      return '                    ';
    } else if (contollerLen == 9) {
      return '                    ';
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your Details'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, snapshot, _) {
                    return Text(generateDateFormat("DD/MM/YYYY"));
                  }),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.datetime,
                inputFormatters: [DateFormatter()],
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
