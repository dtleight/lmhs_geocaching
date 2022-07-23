import 'package:lmhsgeocaching/Containers/LoginContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController loginController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final LoginContainerState activeState;

  LoginPage(this.activeState);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Flexible(
              flex: 8,
              child: Container(
                child: Image.asset("badge-images/logo.png"),
              )),
          Spacer(
            flex: 1,
          ),
          Flexible(
            flex: 1,
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              controller: loginController,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 206, 175, 112)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 206, 175, 112),
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 1),
          Flexible(
              flex: 1,
              child: TextField(
                controller: passwordController,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 206, 175, 112)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 206, 175, 112),
                    ),
                  ),
                ),
                obscureText: true,
                obscuringCharacter: '*',
              )),
          Spacer(
            flex: 1,
          ),
          Flexible(
            child: SignInButton(
              Buttons.Google,
              text: "Sign in with Google",
              onPressed: () async {
                await signInWithGoogle();
                print("Signed in");
                activeState.checkRegistrationStatus();
              },
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Flexible(
            child: SignInButton(
              Buttons.Facebook,
              text: 'Sign in with Facebook',
              onPressed: () {},
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Flexible(
            flex: 1,
            child: TextButton(
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: loginController.text,
                    password: passwordController.text,
                  );
                  //Possible redundancy
                  activeState.checkRegistrationStatus();
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: Text("Submit"),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
            ),
          ),
          Flexible(
              flex: 1,
              child: TextButton(
                  child: Text("Register"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {
                    activeState.updateState("RegisterPage");
                  }))
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    // Should find a way to avoid this null assertion and handle a failed signin
    final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
