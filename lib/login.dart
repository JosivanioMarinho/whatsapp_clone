import 'dart:html';

import 'package:flutter/material.dart';
import 'package:whatsapp/Home.dart';
import 'package:whatsapp/cadastro.dart';
import 'package:whatsapp/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensageErro = "";

  _validarCampos() {
    //Recuperar valores dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty) {
          setState(() {
            _mensageErro = "";
          });

          Usuario usuario = Usuario();
          usuario.email = email;
          usuario.senha = senha;

          _logarUsuario(usuario);
        } else {
          setState(() {
            _mensageErro = "Por favor, digite sua senha";
          });
        }
      } else {
        setState(() {
          _mensageErro = "Por favor, digite um  E-mail válido";
        });
      }
  }

  _logarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
      email: usuario.email, 
      password: usuario.senha
    ).then((firebaseUser){

      Navigator.pushReplacementNamed(context, "/home");
      
    }).catchError((error){

      setState(() {
        _mensageErro = "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente";
      });
    });
  }

  Future _verificarUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    //auth.signOut();

    FirebaseUser usuarioLogado = await auth.currentUser();

    if(usuarioLogado != null){
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075E54)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child:
                      Image.asset("images/logo.png", width: 200, height: 150),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _controllerSenha,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      onPressed: () {
                        _validarCampos();
                      }),
                ),
                Center(
                  child: GestureDetector(
                      child: Text(
                        "Não tem conta? Cadastre-se!",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cadastro()));
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                      child: Text(
                    _mensageErro,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
