import 'dart:html';
import 'dart:async';

class TextEffect {
  HeadingElement textEl;
  InputElement speedEl;

  Duration writeRate = Duration(milliseconds: 300);

  int position = 1;

  String text = 'We Love Programming!';
  Timer? timer;

  TextEffect(this.textEl, this.speedEl) {
    resetTimer();

    speedEl.addEventListener("input", (event) {
      EventTarget? target = event.target;
      if (target is TextInputElement) {
        String? value = target.value;

        if (value is String) {
          int? n = int.tryParse(value);
          if (n != null) {
            updateSpeed(n);
          }
        }
      }
    });
  }

  void resetTimer() {
    timer?.cancel();
    timer = Timer.periodic(writeRate, (timer) {
      writeText();
    });
  }

  void writeText() {
    textEl.innerText = getSlice(position);
    position += 1;
    if (position > text.length) {
      position = 1;
    }
  }

  void updateSpeed(int val) {
    writeRate = Duration(milliseconds: 300 ~/ val);
    resetTimer();
  }

  String getSlice(int position) {
    final buffer = StringBuffer();

    for (int i = 0; i < position; i++) {
      buffer.write(text[i]);
    }

    return buffer.toString();
  }
}

void main() {
  Element? textEl = document.getElementById('text');
  Element? speedEl = document.getElementById('speed');

  if (textEl is HeadingElement && speedEl is InputElement) {
    TextEffect(textEl, speedEl);
  }
}
