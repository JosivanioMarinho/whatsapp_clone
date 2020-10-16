import 'package:flutter/material.dart';
import 'package:whatsapp/login.dart';

void main() {

  //WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25D366),
      ),
      home: Login(),
    )
  );

}

//WidgetsFlutterBinding.ensureInitialized();