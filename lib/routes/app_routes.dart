import 'package:flutter/material.dart';

import '../presentation/main_game/main_game.dart';


class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String onBoardingRoute = '/onboardingRoute';

  static Map<String, WidgetBuilder> get routes => {
        initialRoute: MainGame.builder,
      };
}
