import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';

class VidaiaDrawer extends StatelessWidget {
  const VidaiaDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
        child: Column(children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColorBright,
                radius: 35.0,
              ),
              SizedBox(
                width: 10,
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'UserName',
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
          const Divider(
            color: primaryColorBright,
            thickness: 1,
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(
                Icons.home,
                color: primaryColorBright,
              ),
              title: Text(
                'Home',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              //onTap: () => {context.router.push(const HomeRoute())},
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(
                Icons.settings,
                color: primaryColorBright,
              ),
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              //onTap: () => {context.router.push(const SettingsRoute())},
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(
                Icons.question_mark_rounded,
                color: primaryColorBright,
              ),
              title: Text(
                'FAQ',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () => {null},
            ),
          ),
          Expanded(child: Container()),
          const Divider(
            color: primaryColorBright,
            thickness: 1,
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                color: primaryColorBright,
              ),
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              //onTap: () => {context.router.push(const LoginRoute())},
            ),
          ),
        ]),
      ),
    );
  }
}
