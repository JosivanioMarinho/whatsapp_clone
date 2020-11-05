import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';
import 'package:whatsapp/model/Usuario.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {

  List<Conversa> _listaConversa = List();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  String _idUsuarioLogado;

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();

    Conversa conversa = Conversa();
    conversa.nome = "Ana Maria";
    conversa.mensagem = "Olá tudo bem?";
    conversa.caminhoFoto =
        "https://firebasestorage.googleapis.com/v0/b/whatsapflutter.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=628035e9-2330-481f-afad-30b59adfba30";

    _listaConversa.add(conversa);
  }

  Stream<QuerySnapshot> _adicionarListenerConversa(){

    final stream = db.collection("conversas")
          .document( _idUsuarioLogado )
          .collection("ultimaConversa")
          .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  _recuperarDadosUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    _idUsuarioLogado = user.uid;

    _adicionarListenerConversa();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: Column(children: <Widget>[
                Text("Carregando contatos"),
                CircularProgressIndicator(),
              ]),
            );
            break;
          case ConnectionState.done:

            if (snapshot.hasError) {
              return Text("Erro ao carregar dados!");
            } else {
              QuerySnapshot querySnapshot = snapshot.data;

              if (querySnapshot.documents.length == 0) {
                return Center(
                  child: Text(
                    "Você ainda não tem nenhuma mensagem",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
                  itemCount: _listaConversa.length,
                  itemBuilder: (context, indice) {
                    
                    List<DocumentSnapshot> conversa = querySnapshot.documents.toList();
                    DocumentSnapshot item = conversa[indice];

                    String urlImagem = item["urlImagem"];
                    String tipo = item["tipoMensagem"];
                    String mensagem = item["mensagem"];
                    String nome = item["nome"];
                    String idDestinatario = item["idDestinatario"];

                    Usuario usuario = Usuario();
                    usuario.nome = nome;
                    usuario.urlImagem = urlImagem;
                    usuario.idUsuario = idDestinatario;

                    return ListTile(
                      onTap: (){
                        Navigator.pushNamed(
                          context, 
                          "/mensagens",
                          arguments: usuario
                        );
                      },
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.grey,
                        backgroundImage: urlImagem == null
                        ? NetworkImage(urlImagem)
                        : null
                      ),
                      title: Text( 
                        nome,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        tipo == "texto"
                        ? mensagem
                        : "Imagem...",
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    );
                  });
            }
            break;
        }
      },
    );
  }
}
