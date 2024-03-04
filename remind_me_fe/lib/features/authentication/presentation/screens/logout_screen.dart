import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutByOrientation(LogoutScreenContent());
  }
}

class LogoutScreenContent extends StatelessWidget {
  const LogoutScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Here you can log out."),
        const SizedBox(height: 30),
        IconButton(
          onPressed: () {
            CurrentUser user = sl<CurrentUser>();

            if (!user.isJwtPresent()) {
              return;
            }

            user.clearJwtData();
            AutoRouter.of(context).push(LoginRoute());
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
