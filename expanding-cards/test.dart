import 'dart:html';

void main() {
  var panels = document.querySelectorAll(".panel");
  for (Element panel in panels) {
    armPanel(panel);
  }
}

void deactivateAllPanels() {
  var panels = document.querySelectorAll(".panel");

  for (Element panel in panels) {
    panel.classes.remove("active");
  }
}

void armPanel(Element panel) {
  panel.addEventListener("click", (event) {
    deactivateAllPanels();
    panel.classes.add('active');
  });
}
