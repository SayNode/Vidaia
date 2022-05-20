import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/pages/home/home_page_loader.dart';
import 'package:vidaia/utils/globals.dart';
import 'package:vidaia/utils/wallet.dart';
import 'package:vidaia/services/auth_service.dart';

const users = {
  'a@a.com': 'password',
};

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  bool isProgressing = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  String? name;

  @override
  void initState() {
    initAction();
    super.initState();
  }

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

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    username = data.name;
    password = data.password;
    createNewWallet();
    debugPrint(address);
    var p = await getpriv();
    debugPrint(p);
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Column(
        children: [
          // FlutterLogin(
          //   userType: LoginUserType.name,
          //   logo: const AssetImage('assets/images/vidaia-live-sustainably.png'),
          //   messages:
          //       LoginMessages(userHint: 'Email', passwordHint: 'password'.tr()),
          //   onLogin: _authUser,
          //   onSignup: _signupUser,
          //   onSubmitAnimationCompleted: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => HomePage2()),
          //     );
          //     if (!mnemonicNoted) {
          //       showMnemonicAlert(context);
          //     }
          //   },
          //   onRecoverPassword: _recoverPassword,
          // ),
          TextButton(
            onPressed: loginAction,
            child: const Text('Auth0 Login | Register'),
          ),
          if (isProgressing)
            CircularProgressIndicator()
          else if (!isLoggedIn)
            TextButton(
              onPressed: loginAction,
              child: const Text('Auth0 Login | Register'),
            )
          else
            Text('Welcome $name'),
        ],
      ),
    );
  }

  setSuccessAuthState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
      name = AuthService.instance.idToken?.name;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage2()),
    );
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
      errorMessage = '';
    });
  }

  Future<void> loginAction() async {
    setLoadingState();
    final message = await AuthService.instance.login();
    if (message == 'Success') {
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
        errorMessage = message;
      });
    }
  }

  initAction() async {
    setLoadingState();
    final bool isAuth = await AuthService.instance.init();
    if (isAuth) {
      setSuccessAuthState();
    } else {
      setState(() {
        isProgressing = false;
      });
    }
  }
}
