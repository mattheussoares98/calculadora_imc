import 'dart:io';

class Calculator {
  static calculateImc() {
    String name = _getStringValueThatUserTyped(
      messageForDigitInConsole: "Digite o seu nome:",
    );

    double height = -1;

    height = _getDoubleValueThatUserTyped(
      messageForDigitInConsole: "Digite o sua altura:",
    );

    while (height >= 3 || height <= 0) {
      //com certeza digitou a altura errada
      height = _getDoubleValueThatUserTyped(
        messageForDigitInConsole: "Digite uma altura válida:",
      );
    }

    double weight = _getDoubleValueThatUserTyped(
      messageForDigitInConsole: "Digite o seu peso:",
    );

    while (weight >= 220 || weight <= 0) {
      //com certeza digitou o peso errado
      weight = _getDoubleValueThatUserTyped(
        messageForDigitInConsole: "Digite um peso válido:",
      );
    }

    _printIcmResult(name: name, weight: weight, height: height);
  }

  static double _getDoubleValueThatUserTyped({
    required String messageForDigitInConsole,
  }) {
    double? value;

    while (value == null) {
      print(messageForDigitInConsole);
      String? digitedByUser = stdin.readLineSync();

      if (digitedByUser != null) {
        digitedByUser = digitedByUser.replaceAll(RegExp(r'\,'), '.');
        value = double.tryParse(digitedByUser);

        if (value == null) {
          print("Valor inválido! Digite um valor válido!");
        }
      }
    }

    return value;
  }

  static String _getStringValueThatUserTyped({
    required String messageForDigitInConsole,
  }) {
    String? digitedByUser;

    while (digitedByUser == null || _nameIsInvalid(name: digitedByUser)) {
      print(messageForDigitInConsole);
      digitedByUser = stdin.readLineSync();

      if (digitedByUser != null && _nameIsInvalid(name: digitedByUser)) {
        print("Nome inválido! Digite um valor válido!");
      }
    }

    return digitedByUser;
  }

  static bool _nameIsInvalid({required String name}) {
    return (name.contains("0") ||
            name.contains("1") ||
            name.contains("2") ||
            name.contains("3") ||
            name.contains("4") ||
            name.contains("5") ||
            name.contains("6") ||
            name.contains("7") ||
            name.contains("8") ||
            name.contains("9")) ||
        name.length < 3;
  }

  static _printIcmResult({
    required String name,
    required double weight,
    required double height,
  }) {
    double icm = _calculateImc(weight: weight, height: height);
    String icmInBrazilianNumber =
        icm.toStringAsFixed(2).replaceAll(RegExp(r'\.'), ',');

    if (icm < 16) {
      print(
          'Olá $name, seu IMC é $icmInBrazilianNumber. Resultado: "Magreza grave"');
    } else if (icm < 17) {
      print(
          'Olá $name, seu IMC é $icmInBrazilianNumber. Resultado: "Magreza moderada"');
    } else if (icm < 18.5) {
      print(
          'Olá $name, seu IMC é $icmInBrazilianNumber. Resultado: "Magreza leve"');
    } else if (icm < 25) {
      print(
          'Olá $name, seu IMC é $icmInBrazilianNumber. Resultado: "Saudável"');
    } else if (icm < 30) {
      print(
          'Olá $name, seu IMC é $icmInBrazilianNumber. Resultado: "Sobrepeso"');
    } else if (icm < 35) {
      print(
          'Olá $name, seu IMC é $icmInBrazilianNumber. Resultado: "Obesidade grau I"');
    } else if (icm < 40) {
      print(
          'Olá $name, seu IMC é $icmInBrazilianNumber. Resultado: "Obesidade grau II (severa)"');
    } else {
      print(
          'Olá $name, seu IMC é $icmInBrazilianNumber. Resultado: "Obesidade grau III (mórbido)"');
    }
  }

  static double _calculateImc({
    required double weight,
    required double height,
  }) {
    return weight / (height * height);
  }
}
