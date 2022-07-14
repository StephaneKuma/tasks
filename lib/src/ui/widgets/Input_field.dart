// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.onChange,
    this.widget,
  }) : super(key: key);

  final String title;
  final String hint;
  final ValueChanged<dynamic>? onChange;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: ksTitle,
          ),
          Container(
            height: 52.0,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    cursorColor:
                        Theme.of(context).textSelectionTheme.cursorColor,
                    onChanged: onChange,
                    style: ksSubTitle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: ksSubTitle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).backgroundColor,
                          width: 0.0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).backgroundColor,
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget != null)
                  Container(
                    child: widget,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
