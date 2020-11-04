import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {

  List<Conversa> _listaConversa = List();

   @override
  void initState() {
    super.initState();

    Conversa conversa = Conversa();
    conversa.nome = "Ana Maria";
    conversa.mensagem = "Olá tudo bem?";
    conversa.caminhoFoto = "https://firebasestorage.googleapis.com/v0/b/whatsapflutter.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=628035e9-2330-481f-afad-30b59adfba30";

    _listaConversa.add(conversa);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listaConversa.length,
      itemBuilder: (context, indice){
        
        Conversa conversa = _listaConversa[indice];

        return ListTile(
          /*onTap: (){
            Navigator.pushNamed(
              context, 
              "/mensagens"
            );
          },*/
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
          subtitle: Text(
            conversa.mensagem,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey
            )
          ),
        );
      }
    );
  }
}