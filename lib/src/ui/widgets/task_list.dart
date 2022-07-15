import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/blocs/blocs.dart';
import 'package:tasks/src/cubits/cubits.dart';
import 'package:tasks/src/models/task/task.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';
import 'package:tasks/src/ui/widgets/widgets.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: BlocBuilder<TaskBloc, TaskBlocState>(
        builder: (context, state) {
          context.read<TaskBloc>().add(LoadTasks());
          
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is TaskLoaded) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.tasks.length,
              itemBuilder: (context, index) => TaskTile(
                task: state.tasks[index],
                onTap: () {
                  _showBottomSheet(context: context, task: state.tasks[index]);
                },
              ),
            );
          } else {
            return const Center(
              child: Text('Ooops!! Something went wrong.'),
            );
          }
        },
      ),
    );
  }

  void _showBottomSheet({required BuildContext context, required Task task}) {
    var height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(top: 4.0),
        height: task.isCompleted == 1 ? height * .32 : height * .40,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Container(
                  height: 6.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: state.status == ThemeStatus.dark
                        ? Colors.grey[600]
                        : Colors.grey[300],
                  ),
                );
              },
            ),
            const Spacer(),
            if (task.isCompleted == 0)
              BottomSheetButton(
                title: 'Task Completed',
                color: kcBlueColor,
                onTap: () {
                  context.read<TaskBloc>().add(
                        CompletedTask(task: task),
                      );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your task is completed'),
                    ),
                  );

                  AutoRouter.of(context).pop();
                },
              ),
            BottomSheetButton(
              title: 'Delete Task',
              color: Colors.red[300]!,
              onTap: () {
                context.read<TaskBloc>().add(
                      DeleteTask(task: task),
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Your task is deleted'),
                  ),
                );

                AutoRouter.of(context).pop();
              },
            ),
            const SizedBox(height: 10.0),
            BottomSheetButton(
              title: 'Close',
              color: Colors.red[300]!,
              isClose: true,
              onTap: () {
                AutoRouter.of(context).pop();
              },
            ),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
