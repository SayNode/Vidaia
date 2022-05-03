import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/pages/home/home_page_loader.dart';

const users = {
  'a@a.com': 'password',
};

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.all(40),
      child: FlutterLogin(
        //userType: LoginUserType.name,
        logo: const AssetImage('assets/images/vidaia-live-sustainably.png'),
        messages: LoginMessages(userHint: tr('username')),
        onLogin: _authUser,
        onSignup: _signupUser,

        onSubmitAnimationCompleted: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage2()),
  );
},
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
