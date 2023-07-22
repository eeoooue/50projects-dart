import 'dart:html';

void main() {
  var toggles = document.querySelectorAll('.faq-toggle');

  for (Element toggle in toggles) {
    toggle.addEventListener("click", (event) {
      Node? parent = toggle.parentNode;
      if (parent is Element) {
        parent.classes.toggle("active");
      }
    });
  }
}
