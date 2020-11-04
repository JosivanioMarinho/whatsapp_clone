import 'package:cloud_firestore/cloud_firestore.dart';

class Conversa{

  String _idRemetente;
  String _idDestinatario;
  String _nome;
  String _mensagem;
  String _caminhoFoto;
  String _tipoMensagem;//Texto ou Imagem

  Conversa();

  _salvar() async {

    Firestore db = Firestore.instance;
    db.collection("conversas")
      .document(this.idRemetente)
      .collection("ultimaConversa")
      .document(this.idDestinatario)
      .setData(this.toMap());
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "idRemetente" : this.idRemetente,
      "idDestinatario" : this.idDestinatario,
      "nome" : this.nome,
      "mensagem" : this.mensagem,
      "caminhoFoto" : this.caminhoFoto,
      "tipoMensagem" : this.tipoMensagem,
    };

    return map;
  }

  String get idRemetente => _idRemetente;

  set idRemetente(String idRemetente){
    _idRemetente = idRemetente;
  }

  String get idDestinatario => _idDestinatario;

  set idDestinatario(String idDestinatario){
    _idDestinatario = idDestinatario;
  }

  String get nome => _nome;

  set nome(String nome){
    _nome = nome;
  }

  String get mensagem => _mensagem;

  set mensagem(String mensagem){
    _mensagem = mensagem;
  }

  String get caminhoFoto => _caminhoFoto;

  set caminhoFoto(String caminhoFoto){
    _caminhoFoto = caminhoFoto;
  }

  String get tipoMensagem => _tipoMensagem;

  set tipoMensagem(String tipoMensagem){
    _tipoMensagem = tipoMensagem;
  }
}