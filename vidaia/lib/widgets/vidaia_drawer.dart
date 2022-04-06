import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../utils/router.gr.dart';

class VidaiaDrawer extends StatelessWidget {
  const VidaiaDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade400,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('UserName'),
              )
            ],
          ),
          const Divider(
            color: Colors.red,
            thickness: 1,
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => {context.router.push(const HomeRoute())},
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => {context.router.push(const SettingsRoute())},
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(Icons.question_mark_rounded),
              title: const Text('FAQ'),
              onTap: () => {null},
            ),
          ),
          Expanded(child: Container()),
          const Divider(
            color: Colors.red,
            thickness: 1,
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Logout'),
              onTap: () => {context.router.push(const LoginRoute())},
            ),
          ),
        ]),
      ),
    );
  }
}
