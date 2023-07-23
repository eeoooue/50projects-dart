import 'dart:html';
import 'dart:async';

void main() {
  final buttons = document.querySelectorAll('.ripple');

  for (Element button in buttons) {
    button.addEventListener(("click"), (event) {
      if (event is MouseEvent) {
        Element circle = document.createElement("div");
        circle.classes.add("circle");
        circle.style.top = "${event.offset.y}px";
        circle.style.left = "${event.offset.x}px";

        button.children.add(circle);

        new Timer(Duration(milliseconds: 500), () {
          circle.remove();
        });
      }
    });
  }
}
