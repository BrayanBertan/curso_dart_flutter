class ProdutoValidator {
  String validateImage(List images) {
    if (images.isEmpty) return 'Adicione imagens ao produto';
    return null;
  }

  String validateTitle(String text) {
    if (text.trim().isEmpty) return 'Preencha o titulo do produto';
    return null;
  }

  String validateDescription(String text) {
    if (text.trim().isEmpty) return 'Preencha a descrição do produto';
    return null;
  }

  String validatePrice(String text) {
    double price = double.tryParse(text);

    if (price != null) {
      if (!text.contains('.') || text.split('.')[1].length != 2) {
        return 'Utilize 2 casas decimais';
      }
    } else {
      return 'Preço invalido';
    }
    return null;
  }

  String validateSize(List sizes) {
    if (sizes.isEmpty) return 'Adicione tamanhos ao produto';
    return null;
  }
}
