import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/pages/home/home_page_loader.dart';
import 'package:vidaia/utils/constants.dart';
import 'package:vidaia/utils/globals.dart';
import 'package:vidaia/utils/wallet.dart';
import 'package:vidaia/services/auth_service.dart';
import 'package:vidaia/utils/globals.dart' as global;

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
      decoration: const BoxDecoration(
        image: DecorationImage(alignment: Alignment.centerLeft, image: AssetImage('assets/images/plant_background.jpeg'), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [DARK_GRADIENT, TRANSPARENT_GRADIENT], begin: Alignment.bottomCenter, end: Alignment.center),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isProgressing)
                CircularProgressIndicator()
              else if (!isLoggedIn)
                Column(
                  children: [
                    const Text(
                      'Have it greener with Vidaia.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25, color: TEXT_WHITE, decoration: TextDecoration.none),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: loginAction,
                      child: const Text('Login | Register'),
                      style: elevatedButtonStyle,
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: loginAction,
                      child: const Text('Skip for now'),
                      style: outlinedButtonStyle,
                    ),
                    const SizedBox(height: 30),
                  ],
                )
              else
                Expanded(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome $name',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: TEXT_WHITE, decoration: TextDecoration.none),
                      ),
                      const Icon(
                        Icons.done,
                        color: PRIMARY_LIGHT,
                        size: 130.0,
                      ),
                    ],
                  )),
                ),
            ],
          ),
        ),
      ),
    );
  }

  setSuccessAuthState() async {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
      name = AuthService.instance.idToken?.name;
    });

    if (AuthService.instance.profile.walletAddress.isEmpty) {
      AuthService.instance.profile.walletAddress = await createNewWallet();
      debugPrint('created wallet address is: ' + AuthService.instance.profile.walletAddress);
      await AuthService.instance.updateUserWalletAddress(AuthService.instance.profile);
    } else {
      global.address = AuthService.instance.profile.walletAddress;
    }

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
