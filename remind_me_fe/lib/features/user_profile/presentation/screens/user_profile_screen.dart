import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/bar/presentation/screen_by_orientation.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = sl<CurrentUser>();

    return Scaffold(
      drawer: const RoutesDrawer(),
      body: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: ListTile(
                    title: const Text(
                      'Nickname',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(currentUser.nickname ?? 'Not available'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(currentUser.email ?? 'Not available'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text(
                      'Account type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(currentUser.roles.last),
                  ),
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
