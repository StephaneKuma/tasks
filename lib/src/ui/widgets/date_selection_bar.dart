import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';

class DateSelectionBar extends StatelessWidget {
  const DateSelectionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: DatePicker(
        DateTime.now(),
        height: 100.0,
        width: 65.0,
        initialSelectedDate: DateTime.now(),
        selectionColor: kcBlueColor,
        selectedTextColor: kcWhiteColor,
        dateTextStyle: GoogleFonts.lato(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: GoogleFonts.lato(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: GoogleFonts.lato(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }
}
