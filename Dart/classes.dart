class Teste {
  String _nome;
  int _idade;

  Teste(this._nome, this._idade);

  set idade(int idade) {
    this._idade = (idade > 17) ? idade : 0;
  }

  String toString() => '${this._nome} ${this._idade}';
}

main() {
  Teste teste = Teste('Brayan', 53);
  teste.idade = 5;
  print(teste);
}
