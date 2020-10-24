class Usuario{

  String _nome;
  String _email;
  String _senha;
  String _urlImagem;

  Usuario();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "nome" : this.nome,
      "email" : this.email,
    };

    return map;
  }

  String get nome => _nome;

  set nome(String nome){
    _nome = nome;
  }

  String get email => _email;

  set email(String email){
    _email = email;
  }

  String get senha => _senha;

  set senha(String senha){
    _senha = senha;
  }

  String get urlImagem => _urlImagem;

  set urlImagem(String urlImagem){
    _urlImagem = urlImagem;
  }

}