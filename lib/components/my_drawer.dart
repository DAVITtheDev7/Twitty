import 'package:flutter/material.dart';
import 'package:twitty/components/my_drawer_tile.dart';
import 'package:twitty/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Divider(
              indent: 25,
              endIndent: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            MyDrawerTile(
              title: "H O M E",
              icon: Icons.home,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            MyDrawerTile(
              title: "P R O F I L E",
              icon: Icons.person,
              onTap: () {},
            ),
            MyDrawerTile(
              title: "S E A R C H",
              icon: Icons.search,
              onTap: () {},
            ),
            MyDrawerTile(
              title: "S E T T I G S",
              icon: Icons.settings,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
