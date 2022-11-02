import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pwa_install/features/home/ui/home/home_view.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    /* GoRoute(
      path: '/b',
      builder: (BuildContext context, GoRouterState state) {
        return ScreenB();
      },
    ),*/
  ],
);