import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/cubits/cubits.dart';
import 'package:tasks/src/services/notification_service.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';
import 'package:tasks/src/ui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotificationService service;

  @override
  void initState() {
    service = NotificationService();
    service.initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                state.status == ThemeStatus.light
                    ? Icons.nightlight_round
                    : Icons.sunny,
                color: state.status == ThemeStatus.light
                    ? Colors.black
                    : kcWhiteColor,
                size: 20.0,
              ),
              onPressed: () {
                final status = state.status == ThemeStatus.light
                    ? ThemeStatus.dark
                    : ThemeStatus.light;
                context.read<ThemeCubit>().onChangeTheme(status: status);
                var mode = state.status == ThemeStatus.dark ? 'Light' : 'Dark';
                service.showNotification(
                  id: 0,
                  title: 'App theme changed',
                  body: "$mode mode applied",
                );
              },
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: state.status == ThemeStatus.light
                      ? Colors.black
                      : kcWhiteColor,
                  size: 20.0,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                children: const <Widget>[
                  AddTaskBar(),
                  DateSelectionBar(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
