import 'dart:html';
import 'dart:math';

class HoverboardGrid {
  Element container;
  List<String> colours;
  int squareCount = 500;
  Random randomizer = Random();

  HoverboardGrid(this.container, this.colours) {
    populate();
  }

  void populate() {
    for (int i = 0; i < squareCount; i++) {
      Element square = createSquare();
      container.children.add(square);
    }
  }

  void setColour(Element element) {
    String color = getRandomColour();
    element.style.background = color;
    element.style.boxShadow = "0 0 2px ${color}, 0 0 10px ${color}";
  }

  void removeColour(Element element) {
    element.style.background = '#1d1d1d';
    element.style.boxShadow = '0 0 2px #000';
  }

  String getRandomColour() {
    int i = randomizer.nextInt(colours.length);
    return colours[i];
  }

  Element createSquare() {
    Element square = document.createElement('div');
    square.classes.add('square');

    square.addEventListener('mouseover', (event) {
      setColour(square);
    });

    square.addEventListener('mouseout', (event) {
      removeColour(square);
    });

    return square;
  }
}

void main() {
  Element? container = document.getElementById('container');

  if (container is Element) {
    List<String> colours = List.empty(growable: true);
    colours.add('#e74c3c');
    colours.add('#8e44ad');
    colours.add('#3498db');
    colours.add('#e67e22');
    colours.add('#2ecc71');

    HoverboardGrid(container, colours);
  }
}
