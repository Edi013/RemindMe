// Landscape

import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/features/authentication/presentation/provider/current_user.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:sidebarx/sidebarx.dart';

class LandscapeScaffold extends StatelessWidget {
  final double minimizeContentParameter = 0.7;
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
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            Navigator.pushNamed(context, Routes.homeRoute);
          },
        ),
        SidebarXItem(
          icon: Icons.business,
          label: 'View todos',
          onTap: () {
            Navigator.pushNamed(context, Routes.todoListRoute);
          },
        ),
        SidebarXItem(
          icon: Icons.add,
          label: 'New todo',
          onTap: () {
            Navigator.pushNamed(context, Routes.todoAddRoute);
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
            Icons.list,
            color: theme.colorScheme.secondary,
          ),
          label: 'Todos',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: theme.colorScheme.secondary,
          ),
          label: 'Hello ${sl<CurrentUser>().nickname}',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: theme.colorScheme.secondary,
          ),
          label: 'Home',
        ),
      ],
      onTap: (int index) {
        if (index == 0) {
          Navigator.pushNamed(context, Routes.todoListRoute);
        }
        if (index == 1) {
          Navigator.pushNamed(context, Routes.todoAddRoute);
        }
        if (index == 2) {
          Navigator.pushNamed(context, Routes.homeRoute);
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
            child: const Text('Actions / Screens / Categories'),
          ),
          ListTile(
            title: const Text('User Profile'),
            onTap: () {
              Navigator.pushNamed(context, Routes.userProfile);
            },
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, Routes.homeRoute);
            },
          ),
          ListTile(
            title: const Text('Theme'),
            onTap: () {
              Navigator.pushNamed(context, Routes.themeScreenRoute);
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
