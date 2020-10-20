class Conversa{

  String _nome;
  String _mensagem;
  String _caminhoFoto;

  Conversa(this._nome, this._mensagem, this._caminhoFoto);

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
}