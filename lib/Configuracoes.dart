import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  TextEditingController _controllerNome = TextEditingController();
  File _imagem;
  String _idUsuarioLogado;
  bool _subindoImagem = false;
  String _urlImgemRecuperada;

  Future _recuperarImagem(String origemImagem) async {

    File imagemSelecionada;
    switch(origemImagem){
      case "camera":
        imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _imagem = imagemSelecionada;
      if(_imagem != null){
        _uploadImagem();
        _subindoImagem = true;
      }
    });
  }

  Future _uploadImagem() async {

    //Diretório e nome do arquivo
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
    .child("perfil")
    .child(_idUsuarioLogado + ".jpg");

    //Upload da imagem
    StorageUploadTask task = await arquivo.putFile(_imagem);

    //Controlar progresso do Upload
    task.events.listen((StorageTaskEvent storageTaskEvent) {

      if(storageTaskEvent.type == StorageTaskEventType.progress){
        setState(() {
          _subindoImagem = true;
        });
      }else if(storageTaskEvent.type == StorageTaskEventType.success){
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    //Recuperar url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot) {
      _recuperarUrlImagem(snapshot);
    });
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {

    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFireStorage(url);

    setState(() {
      _urlImgemRecuperada = url;
    });
  }

  _atualizarUrlImagemFireStorage(String url){
    
      Firestore dataBase = Firestore.instance;

      Map<String, dynamic> dadosAtualizados = {
        "urlImagem" : url
      };

      dataBase.collection("usuarios")
      .document(_idUsuarioLogado)
      .updateData(dadosAtualizados);
  }

  _atualizarNomeFireStorage(){
    
      Firestore dataBase = Firestore.instance;

      String nome = _controllerNome.text;
      Map<String, dynamic> dadosAtualizados = {
        "nome" : nome
      };

      dataBase.collection("usuarios")
      .document(_idUsuarioLogado)
      .updateData(dadosAtualizados);
  }

  _recuperarDadosUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await db.collection("usuarios")
    .document(_idUsuarioLogado)
    .get();

     Map<String, dynamic> dados = snapshot.data;

    _controllerNome.text = dados["nome"];

    if(dados["urlImagem"] != null){
     setState(() {
        _urlImgemRecuperada = dados["urlImagem"];
     });
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações")
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: _subindoImagem
                    ? CircularProgressIndicator()
                    : Container(),
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: _urlImgemRecuperada != null
                    ? NetworkImage(_urlImgemRecuperada)
                    : null
                  ,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        _recuperarImagem("camera");
                      }, 
                      child: Text("Câmera")
                    ),
                    FlatButton(
                      onPressed: (){
                        _recuperarImagem("galeria");
                      }, 
                      child: Text("Galeria")
                    ),
                  ],
                ),
                TextField(
                    controller: _controllerNome,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
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
                        "Salvar",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      onPressed: () {
                       _atualizarNomeFireStorage();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}