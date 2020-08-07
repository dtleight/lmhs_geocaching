import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/Account.dart';

class ProfilePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold (
      appBar: AppBar(
        title: Text(new Account().name),
      ),
      );
  }
}