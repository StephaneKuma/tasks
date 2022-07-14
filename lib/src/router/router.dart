import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/ui/pages/pages.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      initial: true,
    ),
    AutoRoute(
      page: AddTaskPage,
      initial: true,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
