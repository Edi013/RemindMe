import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/layout_by_orientation.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/features/home/data/startup_screen_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class ChangeStartupScreen extends StatelessWidget {
  const ChangeStartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutByOrientation(ChangeStartupScreenContent());
  }
}

class ChangeStartupScreenContent extends StatelessWidget {
  const ChangeStartupScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    StartupScreenProvider provider = sl<StartupScreenProvider>();
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "../../../../assets/images/pier-lake-hallstatt-austria.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select your startup screen.',
                style: TextStyle(
                  fontSize: kFontSize,
                  color: white,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.list),
                  ElevatedButton(
                    onPressed: () {
                      provider.changeStartupScreen(allTodosScreen);
                    },
                    child: const Text("All"),
                  ),
                  const VerticalDivider(),
                  const VerticalDivider(),
                  const Icon(Icons.pending_actions_sharp),
                  ElevatedButton(
                    onPressed: () {
                      provider.changeStartupScreen(activeTodosScreen);
                    },
                    child: const Text("Active"),
                  ),
                  const VerticalDivider(),
                  const VerticalDivider(),
                  const Icon(Icons.done),
                  ElevatedButton(
                    onPressed: () {
                      provider.changeStartupScreen(doneTodosScreen);
                    },
                    child: const Text("Done"),
                  ),
                  const VerticalDivider(),
                  const VerticalDivider(),
                  const Icon(Icons.unpublished_rounded),
                  ElevatedButton(
                    onPressed: () {
                      provider.changeStartupScreen(undoneTodosScreen);
                    },
                    child: const Text("Undone"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
