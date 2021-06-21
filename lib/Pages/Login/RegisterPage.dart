import 'package:lmhsgeocaching/Containers/LoginContainer.dart';
import 'package:lmhsgeocaching/Widgets/FormInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

LoginContainerState activeState;

class RegisterPage extends StatelessWidget {
  RegisterPage(LoginContainerState state) {
    activeState = state;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  //Enables later referencing of text controllers.
  List<FormInput> items = [
    FormInput("Name"),
    FormInput("Email"),
    FormInput("Password"),
  ];

  List<TextEditingController> controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ...items
            .map((input) => Padding(
                  padding: EdgeInsets.all(10),
                  child: input,
                ))
            .toList(),
        TextButton(
          onPressed: () async {
            if (await registerUser()) {
              activeState.updateState("RegistrationInfoPage");
            }
          },
          child: Text("Next"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        ),
        TextButton(
          onPressed: () {
            activeState.updateState("LoginHomePage");
          },
          child: Text("Back"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        )
      ]),
    );
  }

  //Might be beneficial to move to LoginContainer
  Future<bool> registerUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: items[1].controller.value.text,
          password: items[2].controller.value.text);
      await FirebaseAuth.instance.currentUser
          .updateDisplayName(items[0].controller.value.text);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "email-already-in-use":
          {
            print("Bad");
          }
          break;
        case "invalid-email":
          {
            print("Bad");
          }
          break;
      }
      return false;
    }
  }
}
