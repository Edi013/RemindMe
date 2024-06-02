// Landscape

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/core/theme/theme_config.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:sidebarx/sidebarx.dart';

// ignore: must_be_immutable
class Sidebar extends StatelessWidget {
  late SidebarXController _controller;

  Sidebar({Key? key}) : super(key: key) {
    _controller = SidebarXController(
      selectedIndex: 0,
      extended: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _controller
        .setExtended(MediaQuery.of(context).size.width >= 1500 ? true : false);

    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        // BUG : Don't remove the decoration, Sidebar will not have bg color without it
        decoration: const BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          color: darkenRed,
        ),
        // hover
        hoverColor: black,
        hoverTextStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: white,
        ),

        // unselected
        textStyle: const TextStyle(color: smokeWhite),
        itemTextPadding: const EdgeInsets.only(left: 30),
        iconTheme: const IconThemeData(
          color: white,
          size: 20,
        ),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),

        // selected
        selectedTextStyle: const TextStyle(
          color: smokeWhite,
        ),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),
        selectedIconTheme: const IconThemeData(
          color: white,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 175,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
        ),
      ),
      headerDivider: const Divider(),
      headerBuilder: (context, extended) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: IconButton(
            icon: Image.asset('assets/images/rm_logo_landscape.png'),
            iconSize: 200,
            onPressed: () {
              AutoRouter.of(context).replace(const HomeRoute());
            },
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.add,
          label: 'New Task',
          onTap: () {
            AutoRouter.of(context).push(const TodoAddRoute());
          },
        ),
        SidebarXItem(
          icon: Icons.list,
          label: 'All Tasks',
          onTap: () {
            AutoRouter.of(context).replace(const TodoListRoute());
          },
        ),
        SidebarXItem(
          icon: Icons.pending_actions_sharp,
          label: 'Active ',
          onTap: () {
            AutoRouter.of(context).replace(const ActiveTodosRoute());
          },
        ),
        SidebarXItem(
          icon: Icons.unpublished_rounded,
          label: 'Unfinished',
          onTap: () {
            AutoRouter.of(context).replace(const UndoneTodosRoute());
          },
        ),
        SidebarXItem(
          icon: Icons.done,
          label: 'Finished',
          onTap: () {
            AutoRouter.of(context).replace(const DoneTodosRoute());
          },
        ),
      ],
    );
  }
}

// Portrait

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.unpublished_rounded, color: white),
          label: 'Unfinished',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.done, color: white),
          label: 'Finished',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.add, color: white),
          label: 'Hello ${sl<CurrentUser>().nickname ?? "User"}',
          //backgroundColor modifies the entire  bar
          backgroundColor: theme.colorScheme.primary.withOpacity(0.85),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.pending_actions_sharp, color: white),
          label: 'Active Tasks',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.list, color: white),
          label: 'All Tasks',
        ),
      ],
      currentIndex: 2,
      onTap: (int index) {
        if (index == 0) {
          AutoRouter.of(context).replace(const UndoneTodosRoute());
        }
        if (index == 1) {
          AutoRouter.of(context).replace(const DoneTodosRoute());
        }
        if (index == 2) {
          AutoRouter.of(context).push(const TodoAddRoute());
        }
        if (index == 3) {
          AutoRouter.of(context).replace(const ActiveTodosRoute());
        }
        if (index == 4) {
          AutoRouter.of(context).replace(const TodoListRoute());
        }
      },
    );
  }
}

// Common
class LeftBurgerButton extends StatelessWidget {
  const LeftBurgerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DrawerButton(),
      ],
    );
  }
}

class RightBurgerButton extends StatelessWidget {
  const RightBurgerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        EndDrawerButton(),
      ],
    );
  }
}

class RoutesDrawer extends StatelessWidget {
  const RoutesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
            ),
            child: const Text(
              'Actions',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('User Profile'),
            onTap: () {
              AutoRouter.of(context).replace(const UserProfileRoute());
            },
          ),
          ListTile(
            title: const Text('Tasks'),
            onTap: () {
              AutoRouter.of(context).replace(const HomeRoute());
            },
          ),
          ListTile(
            title: const Text('Theme'),
            onTap: () {
              AutoRouter.of(context).replace(ThemeRoute(context: context));
            },
          ),
          ListTile(
            title: const Text('Startup View'),
            onTap: () {
              AutoRouter.of(context).replace(const ChangeStartupRoute());
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              AutoRouter.of(context).replace(const LogoutRoute());
            },
          ),
        ],
      ),
    );
  }
}

class LayoutByOrientation extends StatelessWidget {
  final Widget child;
  const LayoutByOrientation(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > constraints.maxHeight) {
          return Scaffold(
            //key: scaffoldKey,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Sidebar(),
                Expanded(child: child),
                const RightBurgerButton(),
              ],
            ),
            endDrawer: const RoutesDrawer(),
          );
        } else {
          return Scaffold(
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LeftBurgerButton(),
                    ),
                    Container(
                      constraints:
                          const BoxConstraints(maxWidth: 100, maxHeight: 60),
                      child: IconButton(
                        icon:
                            Image.asset('assets/images/rm_logo_landscape.png'),
                        iconSize: 200,
                        onPressed: () {
                          AutoRouter.of(context).replace(const HomeRoute());
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: child,
                ),
              ],
            ),
            drawer: const RoutesDrawer(),
            bottomNavigationBar: const BottomBar(),
          );
          ;
        }
      },
    );
  }
}
