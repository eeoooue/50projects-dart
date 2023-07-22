import 'dart:html';

void main() {
  var password = document.getElementById('password');

  password?.addEventListener('input', (event) {
    EventTarget? target = event.target;
    if (target is TextInputElement) {
      String input = target.value!;
      applyPasswordStrength(input);
    }
  });
}

void applyPasswordStrength(String password) {
  Element? background = document.getElementById('background');

  int length = password.length;
  int blurValue = 20 - (length * 2);
  background?.style.filter = "blur(${blurValue}px)";
}
