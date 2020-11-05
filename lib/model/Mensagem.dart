class Mensagem {
  String _idUsuario;
  String _mensagem;
  String _urlImagem;
  String _data;

  //define o tipo da mensagem, que pode ser "testo" ou "imagem"
  String _tipo;

  Mensagem();

  //Mensagem(this._idUsuario, this._mensagem, this._urlImagem, this._tipo);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.idUsuario,
      "mensagem": this.mensagem,
      "urlImagem": this.urlImagem,
      "tipo": this.tipo,
      "data": this.data
    };

    return map;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String idUsuario) {
    _idUsuario = idUsuario;
  }

  String get mensagem => _mensagem;

  set mensagem(String mensagem) {
    _mensagem = mensagem;
  }

  String get urlImagem => _urlImagem;

  set urlImagem(String urlImagem) {
    _urlImagem = urlImagem;
  }

  String get tipo => _tipo;

  set tipo(String tipo) {
    _tipo = tipo;
  }

  String get data => _data;

  set data(String data) {
    _data = data;
  }
}
