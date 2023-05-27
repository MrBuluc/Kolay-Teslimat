import 'package:flutter/material.dart';

class FirstVersionOfMyApp extends StatelessWidget {
  const FirstVersionOfMyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Home Page"),
        ),
        backgroundColor: Colors.white,
        body: buildBody());
  }

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            buildSampleTextWidget(),
            buildMyFirstButton(),
            buildSampleImage(),
            buildCheckbox(),
            buildTextField()
          ],
        ),
      ),
    );
  }

  Widget buildSampleTextWidget() {
    return Container(
        width: 100,
        child: Text(
          "lorem ipsum dolar sit amet",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.red, fontSize: 48, fontWeight: FontWeight.w700),
        ));
  }

  Widget buildMyFirstButton() {
    return Container(
      child: IconButton(
        icon: Icon(Icons.person),
        color: Colors.blue,
        onPressed: () {
          print("My First Button pressed");
        },
      ),
    );
  }

  Widget buildSampleImage() {
    return Container(
      width: 100,
      child: Image.network(
        "https://picsum.photos/250?image=9",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildCheckbox() {
    return Container(
      width: 100,
      child: Checkbox(
        value: true,
        onChanged: (value) {},
      ),
    );
  }

  Widget buildTextField() {
    return Container(
      width: 100,
      child: TextField(
        decoration: InputDecoration(labelText: "Adınızı Giriniz"),
      ),
    );
  }
}
