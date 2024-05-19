import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/core/layout/presentation/layout_by_orientation.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';

@RoutePage()
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LayoutByOrientation(UserProfileScreenContent());
  }
}

class UserProfileScreenContent extends StatelessWidget {
  const UserProfileScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = sl<CurrentUser>();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImagePath),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: ListTile(
              title: const Text(
                'Nickname',
              ),
              subtitle: Text(currentUser.nickname ?? 'Not available',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                'Email',
              ),
              subtitle: Text(currentUser.email ?? 'Not available',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                'Account type',
              ),
              subtitle: Text(currentUser.roles.last,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
