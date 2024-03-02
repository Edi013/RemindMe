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
  //Provider.of<ThemeProvider>(context, listen: true);

  ThemeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selected Theme:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              sl<AppTheme>().currentThemeName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Divider(),
            DropdownButton<String>(
              value: sl<AppTheme>().currentThemeName,
              onChanged: (value) {
                themeProvider.updateTheme(value!);
              },
              items: [dark_theme, light_theme, system_theme]
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
      ),
    );
  }
}
