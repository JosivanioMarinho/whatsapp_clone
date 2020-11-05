import 'package:flutter/material.dart';
import 'package:whatsapp/RouteGenerator.dart';
import 'package:whatsapp/login.dart';
import 'dart:io';

final temaAndroid = ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25D366),
      );

final temaIOS = ThemeData(
        primaryColor: Colors.grey[200],
        accentColor: Color(0xff25D366),
      );

void main() {

  //WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
      theme: Platform.isIOS ? temaIOS : temaAndroid,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    )
  );

}

//WidgetsFlutterBinding.ensureInitialized();