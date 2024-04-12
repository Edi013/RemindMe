import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/layout_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 1,
          height: 1,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              logoutMesage,
              // style: DefaultTextStyle.of(context).style.merge(
              //       const TextStyle(
              //         fontSize: kFontSize,
              //       ),
              //     ),
            ),
            const SizedBox(height: 30),
            IconButton(
              onPressed: () {
                CurrentUser user = sl<CurrentUser>();

                user.clearJwtData();
                AutoRouter.of(context).push(LoginRoute());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        const SizedBox()
      ],
    );
  }
}
