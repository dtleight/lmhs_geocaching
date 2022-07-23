import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  final String text;

  FormInput(this.text);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: text,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder()),
      controller: controller,
    );
  }
}