import 'dart:html';
import 'dart:async';

void main() {
  ElementList<TextInputElement> codes = document.querySelectorAll('.code');

  codes[0].focus();

  for (int i = 0; i < codes.length; i++) {
    TextInputElement el = codes[i];
    el.addEventListener("keydown", (event) {
      if (event is KeyboardEvent && event.key != null) {
        // checking if the keydown event is Backspace
        if (event.code == "Backspace") {
          Timer(Duration(milliseconds: 10), () {
            codes[i - 1].focus();
          });
        } else if (48 <= event.keyCode && event.keyCode <= 57) {
          codes[i].value = "";
          Timer(Duration(milliseconds: 10), () {
            codes[i + 1].focus();
          });
        }
      }
    });
  }
}
