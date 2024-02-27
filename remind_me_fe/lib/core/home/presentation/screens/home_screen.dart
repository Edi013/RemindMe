import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > constraints.maxHeight) {
          return const LandscapeScaffold();
        } else {
          return const PortraitScaffold();
        }
      },
    );
  }
}

// Landscape

class LandscapeScaffold extends StatelessWidget {
  const LandscapeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ExampleSidebarX(),
          const LandscapeContent(),
        ],
      ),
      drawer: const RoutesDrawer(),
    );
  }
}

class LandscapeContent extends StatelessWidget {
  const LandscapeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      // fit the container in the screen, the middle text was overflowing
      height: MediaQuery.of(context).size.height,
      child: const Content(),
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
  const PortraitScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: const Content(),
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
            Icons.business,
            color: theme.colorScheme.secondary,
          ),
          label: 'Todo',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: theme.colorScheme.secondary,
          ),
          label: '',
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
            child: const Text('Drawer Header'),
          ),
          ListTile(
            title: Text('Theme'),
            onTap: () {
              Navigator.pushNamed(context, Routes.themeScreenRoute);
            },
          ),
          // ListTile(
          //   title: Text('User Profile'),
          //   onTap: () {
          //     Navigator.pushNamed(context, Routes.homeRoute);
          //   },
          // ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(" Hello Charlie"),
        Flexible(
          child: Card(
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
            ),
          ),
        ),
        BurgerButton()
      ],
    );
  }
}
