import 'package:flutter/material.dart';
import 'package:whatsapp/Configuracoes.dart';
import 'package:whatsapp/Home.dart';
import 'package:whatsapp/cadastro.dart';
import 'package:whatsapp/login.dart';
import 'package:whatsapp/mensagens.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    //Rotas para o app
    switch(settings.name){
      case "/":
        return MaterialPageRoute(
          builder: (_) => Login()
      );
      case "/login":
        return MaterialPageRoute(
          builder: (_) => Login()
      );
      case "/cadastro":
        return MaterialPageRoute(
          builder: (_) => Cadastro()
      );
      case "/home":
        return MaterialPageRoute(
          builder: (_) => Home()
      );
      case "/configuracoes":
        return MaterialPageRoute(
          builder: (_) => Configuracoes()
      );
      case "/mensagens":
        return MaterialPageRoute(
          builder: (_) => Mensagens(args)
      );
      default:
       _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text("Tela não encontrada!")
          ),
          body: Center(
            child:Text("Tela não encontrada!")
          ),
        );
      }
    );
  }

}