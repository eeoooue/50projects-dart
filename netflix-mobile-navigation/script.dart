import 'dart:html';

void main() {
  var open_btn = document.querySelector('.open-btn');
  var close_btn = document.querySelector('.close-btn');
  var nav = document.querySelectorAll('.nav');

  open_btn?.addEventListener('click', (event) {
    for (Element el in nav) {
      el.classes.add("visible");
    }
  });

  close_btn?.addEventListener('click', (event) {
    for (Element el in nav) {
      el.classes.remove("visible");
    }
  });
}
