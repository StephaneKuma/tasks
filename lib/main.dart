import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/src/blocs/blocs.dart';
import 'package:tasks/src/cubits/cubits.dart';
import 'package:tasks/src/models/models.dart';
import 'package:tasks/src/repositories/repositories.dart';
import 'package:tasks/src/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();

    return MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        RepositoryProvider<TaskRepository>(create: (_) => TaskRepository()),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
          BlocProvider<TaskCubit>(
            create: (context) => TaskCubit(
              repository: context.read<TaskRepository>(),
            ),
          ),
          BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(
              repository: context.read<TaskRepository>(),
            ),
          ),
        ],
        child: BlocConsumer<ThemeCubit, ThemeState>(
          buildWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            SharedPreferences.getInstance().then((prefs) {
              String key = 'isDark';
              bool isDark;

              if (prefs.containsKey(key) && prefs.getBool(key) != null) {
                isDark = prefs.getBool(key)!;
              } else {
                isDark = ThemeState.light().isDark;
                prefs.setBool(key, isDark);
              }

              context.read<ThemeCubit>().onChangeTheme(mode: isDark);
            });
          },
          builder: (context, state) {
            return MaterialApp.router(
              theme: state.theme,
              debugShowCheckedModeBanner: false,
              routerDelegate: router.delegate(),
              routeInformationParser: router.defaultRouteParser(),
            );
          },
        ),
      ),
    );
  }
}
