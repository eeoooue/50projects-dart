import 'dart:html';
import 'dart:math';

class RandomHelper {
  Random random = Random();

  String getRandomLowercaseLetter() {
    String options = "abcdefghijklmnopqrstuvwxyz";
    return getRandomCharFromString(options);
  }

  String getRandomUppercaseLetter() {
    String options = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return getRandomCharFromString(options);
  }

  String getRandomDigit() {
    String options = "1234567890";
    return getRandomCharFromString(options);
  }

  String getRandomSpecialChar() {
    String options = r'!@#$%^&*(){}[]=<>/,.';
    return getRandomCharFromString(options);
  }

  String getRandomCharFromString(String options) {
    int n = options.length;
    int i = random.nextInt(n);
    return options[i];
  }
}

void main() {}
