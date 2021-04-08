class Animal {
  String nome;

  Animal(this.nome);
}

class Cachorro extends Animal {
  String peso;

  Cachorro(String nome, this.peso) : super(nome);
}
