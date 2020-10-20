import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {

  List<Conversa> _listaConversa = [
    Conversa(
      "Ana Clara", 
      "Olá", 
      "https://firebasestorage.googleapis.com/v0/b/whatsapflutter.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=628035e9-2330-481f-afad-30b59adfba30"
    ),
    Conversa(
      "Pedro", 
      "E aí!", 
      "https://firebasestorage.googleapis.com/v0/b/whatsapflutter.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=e2df08c1-043a-40a2-90ce-5071fd55c52e"
    ),
    Conversa(
      "Joana", 
      "Manda o link do curso", 
      "https://firebasestorage.googleapis.com/v0/b/whatsapflutter.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=7c9fc2f0-611d-4771-815f-5a3ca0fee98d"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listaConversa.length,
      itemBuilder: (context, indice){
        
        Conversa conversa = _listaConversa[indice];

        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8 ,16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.caminhoFoto),
          ),
          title: Text(
            conversa.nome,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            )
          ),
        );
      }
    );
  }
}