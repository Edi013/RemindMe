import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me_fe/core/theme/current_app_theme.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/theme/presentation/providers/theme_provider.dart';
import 'package:remind_me_fe/injection_container.dart';

class ThemeScreen extends StatelessWidget {
  late ThemeProvider themeProvider;

  ThemeScreen(BuildContext context, {super.key}) {
    themeProvider = Provider.of<ThemeProvider>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
