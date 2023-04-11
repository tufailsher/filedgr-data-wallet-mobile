import 'package:file_dgr/generated/l10n.dart';
import 'package:file_dgr/ui/about/about.dart';
import 'package:file_dgr/ui/home/home.dart';
import 'package:file_dgr/ui/utils/assets.dart';
import 'package:file_dgr/ui/utils/locale_provider.dart';
import 'package:file_dgr/ui/utils/theme_provider.dart';
import 'package:file_dgr/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// The main screen that hosts the *Home* and *About* screens.
class MainScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final LocaleProvider localeProvider;

  const MainScreen({
    super.key,
    required this.themeProvider,
    required this.localeProvider,
  });

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  MenuOption _selectedItem = MenuOption.home;
  String? _flavorName;

  /// Initializes the state and loads the current flavor name.
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        setState(() {
          if (packageInfo.packageName.endsWith('.dev')) {
            _flavorName = 'DEV';
          } else if (packageInfo.packageName.endsWith('.qa')) {
            _flavorName = 'QA';
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Image(
              image: Assets.image(context, 'app_bar_icon.png'),
              height: 48.0,
            ),
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
                  selectedThemeMode: widget.themeProvider.themeMode.name,
                  selectedLocale:
                      widget.localeProvider.supportedLocale,
                  locales: widget.localeProvider.supportedLocales,
                  onSelected: (menuOption) {
                    Navigator.pop(context);
                    setState(() {
                      _selectedItem = menuOption;
                    });
                  },
                  onChangedTheme: (newThemeMode) {
                    if (newThemeMode == null) return;
                    widget.themeProvider.saveTheme(newThemeMode);
                  },
                  onChangedLocale: (language) {
                    if (language == null) return;
                    widget.localeProvider.saveLocale(language);
                  },
                ),
              ),
            ),
          ),
        ),
        if (_flavorName != null) ...[
          Banner(message: _flavorName!, location: BannerLocation.topStart),
        ],
      ],
    );
  }
}

/// The widget that displays the app drawer.
class AppDrawer extends StatelessWidget {
  final MenuOption selectedItem;
  final String selectedThemeMode;
  final SupportedLocale? selectedLocale;
  final List<SupportedLocale> locales;
  final Function(MenuOption) onSelected;
  final Function(String?) onChangedTheme;
  final Function(String?) onChangedLocale;

  const AppDrawer({
    Key? key,
    required this.selectedItem,
    required this.selectedThemeMode,
    required this.selectedLocale,
    required this.locales,
    required this.onSelected,
    required this.onChangedTheme,
    required this.onChangedLocale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuItem(
              title: MenuOption.home.title,
              icon: Icons.home,
              isSelected: MenuOption.home == selectedItem,
              onTap: () => onSelected(MenuOption.home),
            ),
            MenuItem(
              title: MenuOption.about.title,
              icon: Icons.info,
              isSelected: MenuOption.about == selectedItem,
              onTap: () => onSelected(MenuOption.about),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).theme_,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    underline: const SizedBox(),
                    value: selectedThemeMode.capitalize(),
                    items: ThemeMode.values
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value.name.capitalize(),
                            child: Text(value.name.capitalize()),
                          ),
                        )
                        .toList(),
                    onChanged: (newThemeMode) => onChangedTheme(
                      newThemeMode?.toLowerCase(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).language_,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    underline: const SizedBox(),
                    value: selectedLocale?.language.capitalize(),
                    items: locales
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value.language.capitalize(),
                            child: Text(value.language.capitalize()),
                          ),
                        )
                        .toList(),
                    onChanged: (language) => onChangedLocale(
                      language?.toLowerCase(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The widget that displays a menu option.
class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
      child: ListTile(
        selectedTileColor: isSelected
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
        selected: isSelected,
      ),
    );
  }
}

/// An enum that lists all options that will be displayed in the menu.
enum MenuOption {
  home,
  about;

  String get title {
    switch (this) {
      case MenuOption.home:
        return S.current.home;
      case MenuOption.about:
        return S.current.about;
    }
  }
}
