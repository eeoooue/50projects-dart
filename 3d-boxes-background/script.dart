import 'dart:html';

void main() {
  var boxesContainer = document.getElementById('boxes');

  var btn = document.getElementById('btn');

  btn?.addEventListener('click', (event) {
    boxesContainer?.classes.toggle("big");
  });
  createBoxes();
}

void createBoxes() {
  var boxesContainer = document.getElementById('boxes');

  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      var box = document.createElement('div');
      box.classes.add('box');
      box.style.backgroundPosition = "${-j * 125}px ${-i * 125}px";
      boxesContainer?.children.add(box);
    }
  }
}
