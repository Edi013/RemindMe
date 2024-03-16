// Landscape

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/router/app_router.gr.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:sidebarx/sidebarx.dart';

class LandscapeScaffold extends StatelessWidget {
  final double minimizeContentParameter = 0.35;
  final Widget child;

  const LandscapeScaffold(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ExampleSidebarX(),
          SizedBox(
            width: MediaQuery.of(context).size.width * minimizeContentParameter,
            height: MediaQuery.of(context).size.height,
            child: child,
          ),
          const BurgerButton()
        ],
      ),
      drawer: const RoutesDrawer(),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  final SidebarXController _controller =
      SidebarXController(selectedIndex: 0, extended: true);

  ExampleSidebarX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        // hover
        hoverColor: theme.colorScheme.secondary.withOpacity(0.25),
        hoverTextStyle: const TextStyle(fontWeight: FontWeight.w500),
        // unselected
        textStyle:
            TextStyle(color: theme.colorScheme.secondary.withOpacity(0.85)),
        itemTextPadding: const EdgeInsets.only(left: 30),
        iconTheme: IconThemeData(
          color: theme.colorScheme.secondary,
          size: 20,
        ),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),
        // selected
        selectedTextStyle: TextStyle(color: theme.colorScheme.secondary),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(),
        ),
        selectedIconTheme: IconThemeData(
          color: theme.colorScheme.secondary,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(color: theme.colorScheme.primary),
      ),
      headerDivider: const Divider(),
      headerBuilder: (context, extended) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/images/rm_logo.png'),
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
          icon: Icons.business,
          label: 'All Tasks',
          onTap: () {
            AutoRouter.of(context).push(const TodoListRoute());
          },
        ),
        SidebarXItem(
          icon: Icons.pending_actions_sharp,
          label: 'Active Tasks',
          onTap: () {
            AutoRouter.of(context).push(const ActiveTodosRoute());
          },
        ),
        SidebarXItem(
          icon: Icons.unpublished_rounded,
          label: 'Undone Tasks',
          onTap: () {
            AutoRouter.of(context).push(const UndoneTodosRoute());
          },
        ),
        SidebarXItem(
          icon: Icons.done,
          label: 'Done Tasks',
          onTap: () {
            AutoRouter.of(context).push(const DoneTodosRoute());
          },
        ),
      ],
    );
  }
}

// Portrait

class PortraitScaffold extends StatelessWidget {
  final double minimizeContentParameter = 0.015;
  final Widget child;

  const PortraitScaffold(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: Row(
        children: [
          SizedBox(
            width: width * minimizeContentParameter,
            height: height,
          ),
          SizedBox(
            width: width * (1 - 2 * minimizeContentParameter),
            height: height,
            child: child,
          ),
          SizedBox(
            width: width * minimizeContentParameter,
            height: height,
          ),
        ],
      ),
      drawer: const RoutesDrawer(),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.unpublished_rounded,
            color: theme.colorScheme.secondary,
          ),
          label: 'Undone Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.done,
            color: theme.colorScheme.secondary,
          ),
          label: 'Done Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: theme.colorScheme.secondary,
          ),
          label: 'G\'day ${sl<CurrentUser>().nickname ?? "User"}',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pending_actions_sharp,
            color: theme.colorScheme.secondary,
          ),
          label: 'Active Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
            color: theme.colorScheme.secondary,
          ),
          label: 'All Tasks',
        ),
      ],
      currentIndex: 1,
      onTap: (int index) {
        if (index == 0) {
          AutoRouter.of(context).push(const UndoneTodosRoute());
        }
        if (index == 1) {
          AutoRouter.of(context).push(const DoneTodosRoute());
        }
        if (index == 2) {
          AutoRouter.of(context).push(const TodoAddRoute());
        }
        if (index == 3) {
          AutoRouter.of(context).push(const ActiveTodosRoute());
        }
        if (index == 4) {
          AutoRouter.of(context).push(const TodoListRoute());
        }
      },
    );
  }
}

// Common
class BurgerButton extends StatelessWidget {
  const BurgerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DrawerButton(),
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
                'Streets / Routes / Directions / Actions / Screens / Categories'),
          ),
          ListTile(
            title: const Text('User Profile'),
            onTap: () {
              AutoRouter.of(context).push(const UserProfileRoute());
            },
          ),
          ListTile(
            title: const Text('Tasks'),
            onTap: () {
              AutoRouter.of(context).push(const HomeRoute());
            },
          ),
          ListTile(
            title: const Text('Theme'),
            onTap: () {
              AutoRouter.of(context).push(ThemeRoute(context: context));
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              AutoRouter.of(context).push(const LogoutRoute());
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
          return LandscapeScaffold(child);
        } else {
          return PortraitScaffold(child);
        }
      },
    );
  }
}
