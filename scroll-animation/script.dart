import 'dart:html';

void main() {
  window.addEventListener('scroll', (event) {
    checkBoxes();
  });

  checkBoxes();
}

void checkBoxes() {
  var triggerBottom = window.innerHeight! / 5 * 4;

  for (Element box in document.querySelectorAll('.box')) {
    Rectangle boundingBox = box.getBoundingClientRect();

    if (boundingBox.top < triggerBottom) {
      box.classes.add('show');
    } else {
      box.classes.remove('show');
    }
  }
}
