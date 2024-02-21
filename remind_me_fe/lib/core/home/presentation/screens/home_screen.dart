import 'package:flutter/material.dart';
import 'package:remind_me_fe/core/routes.dart';
import 'package:remind_me_fe/features/theme/presentation/providers/theme_provider.dart';
import 'package:remind_me_fe/injection_container.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

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

class PortraitScaffold extends StatelessWidget {
  const PortraitScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.todoListRoute);
          },
          child: const Text('Go to Todo List'),
        ),
      ),
      drawer: const RoutesDrawer(),
      bottomNavigationBar: const ActionBottomBar(),
    );
  }
}

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
          const MiddleClusterData(),
          const Column(
            children: [
              DrawerButton(),
            ],
          ),
        ],
      ),
      drawer: const RoutesDrawer(),
    );
  }
}

class ActionBottomBar extends StatelessWidget {
  const ActionBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Todo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: sl<ThemeProvider>().appTheme.getAccentColor(),
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

class RoutesDrawer extends StatelessWidget {
  const RoutesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: Text('Theme'),
            onTap: () {
              Navigator.pushNamed(context, Routes.themeScreenRoute);
            },
          ),
          ListTile(
            title: Text('User Profile'),
            onTap: () {
              Navigator.pushNamed(context, Routes.homeRoute);
            },
          ),
        ],
      ),
    );
  }
}

class MiddleClusterData extends StatelessWidget {
  const MiddleClusterData({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(" Hello Charlie"),
        const Card(child: Text("You have done")),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.todoListRoute);
          },
          child: const Text('Go to Todo List'),
        ),
      ],
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  final SidebarXController _controller =
      SidebarXController(selectedIndex: 0, extended: true);

  ExampleSidebarX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          //color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        // hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(), //color: canvasColor
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              //color: actionColor.withOpacity(0.37),
              ),
          // gradient: const LinearGradient(
          //     //colors: [accentCanvasColor, canvasColor],
          //     ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
            //color: canvasColor,
            ),
      ),
      headerDivider: const Divider(),
      headerBuilder: (context, extended) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
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
          icon: Icons.plus_one,
          label: '+',
          onTap: () {
            Navigator.pushNamed(context, Routes.homeRoute);
          },
        ),
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            Navigator.pushNamed(context, Routes.homeRoute);
          },
        ),
      ],
    );
  }
}
