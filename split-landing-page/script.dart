import 'dart:html';

class SensitiveContainer {
  Element container;

  SensitiveContainer(this.container, Element? leftArea, Element? rightArea) {
    if (leftArea != null) {
      addListeners(leftArea, 'hover-left');
    }

    if (rightArea != null) {
      addListeners(rightArea, 'hover-right');
    }
  }

  void addListeners(Element element, String classname) {
    element.addEventListener("mouseenter", (event) {
      this.container.classes.add(classname);
    });
    element.addEventListener("mouseleave", (event) {
      this.container.classes.remove(classname);
    });
  }
}

void main() {
  Element? container = document.querySelector('.container');

  if (container != null) {
    Element? left = document.querySelector('.left');
    Element? right = document.querySelector('.right');

    SensitiveContainer(container, left, right);
  }
}
