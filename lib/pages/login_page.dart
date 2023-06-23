// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kolayca_teslimat/stores/auth_store.dart';
import 'package:kolayca_teslimat/stores/root_store.dart';
import 'package:kolayca_teslimat/stores/theme_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneCnt = TextEditingController();

  bool loginIsStarted = false;

  late ThemeStore themeStore;
  late AuthStore authStore;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((sharedPreference) {
      phoneCnt.text = sharedPreference.getString("phoneNo") ?? "";
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    RootStore rootStore = Provider.of<RootStore>(context);
    themeStore = rootStore.themeStore;
    authStore = rootStore.authStore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
              tag: "logo",
              child: Observer(builder: (context) {
                return Icon(
                  Icons.local_shipping,
                  size: 100,
                  color: themeStore.primaryColor,
                );
              })),
          buildPhoneNo(),
          buildLoginButton(),
        ],
      ),
    );
  }

  Widget buildPhoneNo() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white),
      child: TextField(
        controller: phoneCnt,
        decoration: InputDecoration(
            hintText: "Phone No",
            icon: Observer(builder: (context) {
              return Icon(
                Icons.person,
                color: themeStore.primaryColor,
              );
            })),
      ),
    );
  }

  Widget buildLoginButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: loginIsStarted
          ? const SizedBox(
              width: 50, height: 50, child: CircularProgressIndicator())
          : SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  attemptLogin();
                },
                child: const Text("Giriş Yap"),
              ),
            ),
    );
  }

  attemptLogin() {
    if (phoneCnt.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lütfen telefon No giriniz")));
    } else {
      startLoginRequest();
    }
  }

  Future startLoginRequest() async {
    try {
      await authStore.login(phoneCnt.text);

      if (authStore.isLoggedIn) {
        (await SharedPreferences.getInstance())
            .setString("phoneNo", phoneCnt.text);
        Navigator.of(context).pushReplacementNamed(Routes.home);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Bilgileriniz Hatalı")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Bilgileriniz Hatalı")));
    }
  }

  startFakeRequest() {
    setState(() {
      loginIsStarted = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        loginIsStarted = false;
      });

      SharedPreferences.getInstance().then((sharedPreferences) {
        sharedPreferences.setString("phoneNo", phoneCnt.text);
      });

      if (phoneCnt.text == "123456") {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Bilgileriniz Hatalı")));
      }
    });
  }
}
