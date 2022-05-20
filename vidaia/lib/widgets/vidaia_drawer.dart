import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/pages/home/home_page_loader.dart';
import 'package:vidaia/pages/login_page.dart';
import 'package:vidaia/pages/settings_page.dart';
import 'package:vidaia/repositories/dataRepository.dart';
import 'package:vidaia/services/auth_service.dart';
import 'package:vidaia/utils/constants.dart';

class VidaiaDrawer extends StatelessWidget {
  VidaiaDrawer({Key? key}) : super(key: key);

  DataRepository dataRepository = getIt.get<DataRepository>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColorBright,
                foregroundImage: AssetImage("assets/images/Me.jpg"),
                radius: 35.0,
              ),
              const SizedBox(
                width: 10,
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  dataRepository.userinfo.displayName,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
          const Divider(
            color: CLICKED,
            thickness: 1,
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: PRIMARY_LIGHT,
              ),
              title: Text(
                'Home',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage2()),
                );
              },
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                color: PRIMARY_LIGHT,
              ),
              title: Text(
                'settings'.tr(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: const Icon(
                Icons.question_mark_rounded,
                color: PRIMARY_LIGHT,
              ),
              title: Text(
                'FAQ',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () => {null},
            ),
          ),
          const Divider(
            color: CLICKED,
            thickness: 1,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Connect profile',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: Image(
                image: AssetImage("assets/images/migros.png"),
                height: 25,
              ),
              title: Text(
                'Migros',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () => {null},
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: Image(
                image: AssetImage("assets/images/coop.png"),
                height: 25,
                width: 30,
              ),
              title: Text(
                'Coop',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () => {null},
            ),
          ),
          Expanded(child: Container()),
          const Divider(
            color: CLICKED,
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
                onTap: () async {
                  await AuthService.instance.logout();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
          ),
        ]),
      ),
    );
  }
}
