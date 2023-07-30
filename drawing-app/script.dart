import 'dart:html';
import 'dart:math';

class DrawingApp {
  CanvasElement canvas;
  int size = 10;
  late dynamic ctx;

  num x = 0;
  num y = 0;
  bool isPressed = false;
  String colour = "#000000";

  DrawingApp(this.canvas) {
    ctx = canvas.getContext('2d');
    armCanvas();
  }

  void armCanvas() {
    canvas.addEventListener('mousedown', (event) {
      if (event is MouseEvent) {
        isPressed = true;
        x = event.offset.x;
        y = event.offset.y;
      }
    });

    document.addEventListener('mouseup', (event) {
      isPressed = false;
      x = 0;
      y = 0;
    });

    canvas.addEventListener('mousemove', (event) {
      if (event is MouseEvent && isPressed) {
        var x2 = event.offset.x;
        var y2 = event.offset.y;

        drawCircle(x2, y2);
        drawLine(x, y, x2, y2);

        x = x2;
        y = y2;
      }
    });
  }

  void drawCircle(x, y) {
    ctx.beginPath();
    ctx.arc(x, y, size, 0, 3.1415 * 2);
    ctx.fillStyle = colour;
    ctx.fill();
  }

  void drawLine(x1, y1, x2, y2) {
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.strokeStyle = colour;
    ctx.lineWidth = size * 2;
    ctx.stroke();
  }

  void changeSize(int amount) {
    size += amount;
    size = max(size, 5);
    size = min(size, 50);

    var span = document.getElementById('size');
    if (span is Element) {
      span.innerText = size.toString();
    }
  }

  void clear() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
  }

  void submitColour(String newColour) {
    colour = newColour;
  }
}

class SizePicker {
  DrawingApp app;

  ButtonElement decreaseBtn;
  ButtonElement increaseBtn;
  SizePicker(this.app, this.decreaseBtn, this.increaseBtn) {
    decreaseBtn.addEventListener("click", (event) => app.changeSize(-5));
    increaseBtn.addEventListener("click", (event) => app.changeSize(5));
  }
}

class ColourPicker {
  DrawingApp app;

  InputElement element;
  ColourPicker(this.app, this.element) {
    element.addEventListener("change", (event) {
      var val = element.value;
      if (val is String) {
        app.submitColour(val);
      }
    });
  }
}

class ClearButton {
  DrawingApp app;

  ButtonElement element;
  ClearButton(this.app, this.element) {
    element.addEventListener("click", (event) => app.clear());
  }
}

void main() {
  var canvas = document.getElementById('canvas');

  if (canvas is CanvasElement) {
    DrawingApp app = DrawingApp(canvas);

    var increaseBtn = document.getElementById('increase');
    var decreaseBtn = document.getElementById('decrease');
    if (increaseBtn is ButtonElement && decreaseBtn is ButtonElement) {
      SizePicker(app, decreaseBtn, increaseBtn);
    }

    var colorEl = document.getElementById('color');
    if (colorEl is InputElement) {
      ColourPicker(app, colorEl);
    }

    var clearEl = document.getElementById('clear');
    if (clearEl is ButtonElement) {
      ClearButton(app, clearEl);
    }
  }
}
