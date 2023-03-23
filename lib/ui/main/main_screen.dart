import 'package:file_dgr/ui/about/about.dart';
import 'package:file_dgr/ui/home/home.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  MenuOption _selectedItem = MenuOption.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filedgr'.toUpperCase()),
      ),
      body: Builder(builder: (context) {
        if (_selectedItem == MenuOption.home) {
          return const Home();
        } else {
          return const About();
        }
      }),
      drawer: SafeArea(
        child: SizedBox(
          child: Drawer(
            child: AppDrawer(
              selectedItem: _selectedItem,
              onSelected: (menuOption) {
                Navigator.pop(context);
                setState(() {
                  _selectedItem = menuOption;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final MenuOption selectedItem;
  final Function(MenuOption) onSelected;

  const AppDrawer({
    Key? key,
    required this.selectedItem,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MenuItem(
          MenuOption.home.title,
          isSelected: MenuOption.home == selectedItem,
          onTap: () => onSelected(MenuOption.home),
        ),
        MenuItem(
          MenuOption.about.title,
          isSelected: MenuOption.about == selectedItem,
          onTap: () => onSelected(MenuOption.about),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuItem(
    this.label, {
    Key? key,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: onTap,
      selected: isSelected,
    );
  }
}

enum MenuOption {
  home('Home'),
  about('About');

  const MenuOption(this.title);

  final String title;
}
