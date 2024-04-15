import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/features/home/data/startup_screen_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return sl<StartupScreenProvider>().loadSelectedDefaultScreen();
  }
}
