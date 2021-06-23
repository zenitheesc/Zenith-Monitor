class User {
  User(this.name, this.imageLink, this.accessLevel);
  //o Dart implementou uma coisa chamada null safety,
  //meio que nós devemos especificar se uma variavel pode ser null ou nao

  String name; //não pode ser null
  String? imageLink; //pode ser null
  String accessLevel; //não pode ser null

}
