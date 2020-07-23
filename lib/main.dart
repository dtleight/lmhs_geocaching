import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    //Potentially removes extra database instantiations
    /**
    return Provider<DatabaseRouting>(
      builder: (_) => new DatabaseRouting(),
      child: MaterialApp(
        title: 'Flutter Login',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        //PageContainer()
      ),
    );

  }
     **/
    return MaterialApp(
      title: 'Flutter Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      //PageContainer()
    );
  }
}
