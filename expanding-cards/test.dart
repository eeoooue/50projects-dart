import 'dart:html';

class Overseer {
  void createPanels() {
    for (Element element in document.querySelectorAll(".panel")) {
      Panel(this, element);
    }
  }

  void deactivateAllPanels() {
    var panels = document.querySelectorAll(".panel");
    for (Element panel in panels) {
      panel.classes.remove("active");
    }
  }
}

class Panel {
  late Element element;
  late Overseer seer;

  Panel(Overseer seer, Element element) {
    this.seer = seer;
    this.element = element;
    addListener();
  }

  addListener() {
    this.element.addEventListener("click", (event) {
      this.seer.deactivateAllPanels();
      this.element.classes.add("active");
    });
  }
}

void main() {
  Overseer seer = Overseer();
  seer.createPanels();
}
