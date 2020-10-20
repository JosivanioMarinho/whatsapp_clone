import 'package:flutter/material.dart';
import 'package:whatsapp/RouteGenerator.dart';
import 'package:whatsapp/login.dart';

void main() {

  //WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25D366),
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    )
  );

}

//WidgetsFlutterBinding.ensureInitialized();