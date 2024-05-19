import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/layout/presentation/layout_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImagePath),
          fit: BoxFit.fill,
        ),
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 1,
              height: 1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        logoutMesage,
                        style: DefaultTextStyle.of(context).style.merge(
                              const TextStyle(
                                fontSize: kHeadingMediumFontSize,
                                color: white,
                              ),
                            ),
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
                ),
              ],
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
