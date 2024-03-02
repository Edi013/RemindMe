import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/features/theme/data/local/current_app_theme.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/theme/presentation/providers/theme_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

// ignore: must_be_immutable
class ThemeScreen extends StatelessWidget {
  const ThemeScreen(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutByOrientation(ThemeScreenContent());
  }
}

class ThemeScreenContent extends StatelessWidget {
  final ThemeProvider themeProvider = sl<ThemeProvider>();
  final double spacerForTitles = 30;

  ThemeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Change your theme :",
                          style: TextStyle(fontSize: 23),
                        ),
                        SizedBox(height: spacerForTitles),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.light_mode_outlined),
                            ElevatedButton(
                              onPressed: () {
                                themeProvider.updateTheme(light_theme_name);
                              },
                              child: const Text("Light theme"),
                            ),
                          ],
                        ),
                        SizedBox(height: spacerForTitles / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.gpp_good_outlined),
                            ElevatedButton(
                              onPressed: () {
                                themeProvider.updateTheme(system_theme_name);
                              },
                              child: const Text("System theme"),
                            ),
                          ],
                        ),
                        SizedBox(height: spacerForTitles / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.dark_mode_outlined),
                            ElevatedButton(
                              onPressed: () {
                                themeProvider.updateTheme(dark_theme_name);
                              },
                              child: const Text("Dark theme"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  children: [
                    const Text(
                      'Selected Theme:',
                      style: TextStyle(fontSize: 23),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: sl<AppTheme>().currentThemeName,
                      onChanged: (value) {
                        themeProvider.updateTheme(value!);
                      },
                      items:
                          [dark_theme_name, light_theme_name, system_theme_name]
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const BurgerButton()
        ],
      ),
    );
  }
}