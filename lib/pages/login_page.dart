import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneCnt = TextEditingController();

  bool loginIsStarted = false;

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
        children: [buildPhoneNo(), buildLoginButton()],
      ),
    );
  }

  Widget buildPhoneNo() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white),
      child: TextField(
        controller: phoneCnt,
        decoration:
            InputDecoration(hintText: "Phone No", icon: Icon(Icons.person)),
      ),
    );
  }

  Widget buildLoginButton() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: loginIsStarted
          ? SizedBox(width: 50, height: 50, child: CircularProgressIndicator())
          : SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  attemptLogin();
                },
                child: Text("Giriş Yap"),
              ),
            ),
    );
  }

  attemptLogin() {
    if (phoneCnt.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Lütfen telefon No giriniz")));
    } else {
      startFakeRequest();
    }
  }

  startFakeRequest() {
    setState(() {
      loginIsStarted = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loginIsStarted = false;
      });

      if (phoneCnt.text == "123456") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Bilgileriniz Doğru")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Bilgileriniz Hatalı")));
      }
    });
  }
}
