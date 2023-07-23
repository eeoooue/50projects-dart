import 'dart:collection';
import 'dart:math';
import 'dart:html';

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

void main() {
  var generateEl = document.getElementById('generate');
  var clipboardEl = document.getElementById('clipboard');
  var resultEl = document.getElementById('result');

  var lengthEl = document.getElementById('length');

  generateEl?.addEventListener("click", (event) {
    if (lengthEl is NumberInputElement && lengthEl.value != null) {
      String pass = generatePassword(int.parse(lengthEl.value!));

      if (resultEl is Element) {
        resultEl.innerText = pass;
      }
    }
  });

  clipboardEl?.addEventListener("click", (event) {
    if (resultEl is Element) {
      String pass = resultEl.innerText;
      // navigator.clipboard.writeText(password);
      window.alert('Password [ ${pass} ] needs to be copied to clipboard!');
    }
  });
}

bool includeLowercase() {
  return checkCheckboxOfClass('lowercase');
}

bool includeUppercase() {
  return checkCheckboxOfClass('uppercase');
}

bool includeDigit() {
  return checkCheckboxOfClass('numbers');
}

bool includeSymbols() {
  return checkCheckboxOfClass('symbols');
}

bool checkCheckboxOfClass(String classname) {
  Element? element = document.getElementById(classname);

  if (element is CheckboxInputElement) {
    return element.checked == true;
  }

  return false;
}

String generatePassword(int length) {
  StringBuffer buffer = StringBuffer();

  RandomHelper helper = RandomHelper();

  Queue<String> queue = Queue();

  if (includeLowercase()) {
    queue.add("lowercase");
  }

  if (includeUppercase()) {
    queue.add("uppercase");
  }

  if (includeDigit()) {
    queue.add("digit");
  }

  if (includeSymbols()) {
    queue.add("special");
  }

  if (queue.length == 0) {
    return "";
  }

  for (int i = 0; i < length; i++) {
    String slotType = queue.removeFirst();
    queue.add(slotType);

    String letter;

    switch (slotType) {
      case "uppercase":
        {
          letter = helper.getRandomUppercaseLetter();
        }

      case "digit":
        {
          letter = helper.getRandomDigit();
        }

      case "special":
        {
          letter = helper.getRandomSpecialChar();
        }

      default:
        {
          letter = helper.getRandomLowercaseLetter();
        }
    }

    buffer.write(letter);
  }

  return buffer.toString();
}
