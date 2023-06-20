import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  String dateModal = 'DD/MM/YYYY';

  String generateDateFormat(String input) {
    List<String> dateModalList = dateModal.split('');
    int controllerLen = input.length;

    if (controllerLen == 0) {
      return dateModalList.join();
    } else if (controllerLen <= dateModalList.length) {
      List<String> formattedDate = List.from(dateModalList);

      for (int i = 0; i < controllerLen; i++) {
        formattedDate[i] = input[i];
      }
      return formattedDate.join();
    } else {
      return "";
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int selectionIndex;

    String prevText = oldValue.text;
    String currText = newValue.text;

    int currLen = currText.length;
    int prevLen = prevText.length;

    if (currLen == 1) {
      if (int.parse(currText) > 3) {
        currText = "0$currText/";
      }
    } else if (currLen == 2 && prevLen == 1) {
      int dd = int.parse(currText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        currText = currText.substring(0, 1);
      } else {
        currText += '/';
      }
    } else if (currLen == 4) {
      if (int.parse(currText.substring(3, 4)) > 1) {
        currText = "${currText.substring(0, 3)}0${currText.substring(3, 4)}";
      } else {}
    } else if (currLen == 5 && prevLen == 4) {
      int mm = int.parse(currText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        currText = currText.substring(0, 4);
      } else {
        currText += '/';
      }
    } else if (currLen == 3 && prevLen == 2) {
      if (int.parse(currText.substring(2, 3)) > 1) {
        currText = '${currText.substring(0, 2)}/';
      } else {
        currText =
            '${currText.substring(0, prevLen)}/${currText.substring(prevLen, prevLen + 1)}';
      }
    } else if (currLen == 6 && prevLen == 5) {
      int y1 = int.parse(currText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        currText = '${currText.substring(0, 5)}/';
      } else {
        currText = '${currText.substring(0, 5)}/${currText.substring(5, 6)}';
      }
    } else if (currLen == 7) {
      int y1 = int.parse(currText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        currText = currText.substring(0, 6);
      }
    } else if (currLen == 11) {
      currText = currText.substring(0, 10);
    }

    selectionIndex = currText.length;
    return TextEditingValue(
      text: currText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
