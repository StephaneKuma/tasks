import 'package:flutter/material.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.color,
    this.isClose = false,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Color? color;
  final bool isClose;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        height: 50.0,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          color: isClose ? Colors.transparent : color,
          border: Border.all(
            width: 2.0,
            color: isClose
                ? Theme.of(context).textSelectionTheme.cursorColor!
                : color!,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(
            title,
            style: isClose
                ? ksTitle.copyWith(color: Colors.black)
                : ksTitle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
