import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/cubits/cubits.dart';
import 'package:tasks/src/router/router.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: ksSubHeading.copyWith(
                    color: state.status == ThemeStatus.light
                        ? Colors.grey
                        : Colors.grey[400],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Today',
                  style: ksHeading,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(const AddTaskRoute());
              },
              style: ElevatedButton.styleFrom(
                primary: kcBlueColor,
                shape: const StadiumBorder(),
                fixedSize: const Size.fromHeight(50.0),
              ),
              child: Row(
                children: const <Widget>[
                  Icon(Icons.add_circle_outline_sharp),
                  SizedBox(width: 5.0),
                  Text('Add Task'),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
