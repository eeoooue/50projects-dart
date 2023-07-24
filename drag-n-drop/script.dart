import 'dart:html';
import 'dart:async';

class DragDropBox {
  Element element;
  DragDropBox(this.element) {
    element.addEventListener("dragover", (event) {
      event.preventDefault();
    });
    element.addEventListener("dragenter", (event) {
      event.preventDefault();
      element.classes.add("hovered");
    });
    element.addEventListener("dragleave", (event) {
      element.classes.clear();
      element.classes.add("empty");
    });
    element.addEventListener("drop", (event) {
      print("recorded a drop event");
      element.classes.clear();
      element.classes.add("empty");

      Timer(Duration(milliseconds: 1), () {
        var fill = document.querySelector('.fill');
        if (fill is Element) {
          element.children.add(fill);
          print("appended fill to box");
        }
      });
    });
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
        fill.classes.clear();
        fill.classes.add("invisible");
      });
    });

    fill.addEventListener("dragend", (event) {
      fill.classes.clear();
      fill.classes.add("fill");
      print("you finished dragging");
    });
  }
}
