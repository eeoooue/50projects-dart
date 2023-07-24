import 'dart:html';
import 'dart:async';

class DragDropBox {
  Element element;
  DragDropBox(this.element) {
    setupListeners();
  }

  void setupListeners() {
    element.addEventListener("dragover", (event) {
      event.preventDefault();
    });
    element.addEventListener("dragenter", (event) {
      event.preventDefault();
      element.classes.add("hovered");
    });
    element.addEventListener("dragleave", (event) {
      element.classes.remove("hovered");
    });
    element.addEventListener("drop", (event) {
      element.classes.remove("hovered");
      grabFill();
    });
  }

  void grabFill() {
    Element? fill = document.querySelector('.fill');
    if (fill is Element) {
      element.children.add(fill);
    }
  }
}

void main() {
  List<Element> empties = document.querySelectorAll('.empty');

  for (Element empty in empties) {
    DragDropBox(empty);
  }

  Element? fill = document.querySelector('.fill');
  if (fill is Element) {
    fill.addEventListener("dragstart", (event) {
      fill.classes.add("hold");
      Timer(Duration(seconds: 0), () {
        fill.classes.add("invisible");
      });
    });

    fill.addEventListener("dragend", (event) {
      fill.classes.remove("hold");
      fill.classes.remove("invisible");
    });
  }
}
