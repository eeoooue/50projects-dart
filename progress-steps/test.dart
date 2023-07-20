import 'dart:html';

class ProgressPath {
  int currentActive = 1;
  late PrevButton prevBtn;
  late NextButton nextBtn;

  ProgressPath() {
    prevBtn = PrevButton(this);
    nextBtn = NextButton(this);
  }

  void move(int change) {
    var circles = document.querySelectorAll('.circle');

    currentActive += change;

    if (currentActive < 1) {
      currentActive = 1;
    } else if (currentActive > circles.length) {
      currentActive = circles.length;
    }

    update();
  }

  void setBarWidth(int current, int maximum) {
    Element? progress = document.getElementById('progress');
    progress?.style.width = "${(current - 1) / (maximum - 1) * 100}%";
  }

  void update() {
    var circles = document.querySelectorAll('.circle');

    int i = 1;
    for (Element circle in circles) {
      circle.classes.remove("active");
      if (i <= currentActive) {
        circle.classes.add("active");
      }
      i += 1;
    }

    prevBtn.enable();
    nextBtn.enable();

    if (currentActive == 1) {
      prevBtn.disable();
    }

    if (currentActive == circles.length) {
      nextBtn.disable();
    }

    setBarWidth(currentActive, circles.length);
  }
}

class PathButton {
  late ProgressPath path;
  late ButtonElement btnElement;

  PathButton(ProgressPath path, String identifier) {
    this.path = path;

    Element? element = document.getElementById(identifier);
    if (element is ButtonElement) {
      ButtonElement btn = element;
      this.btnElement = btn;
    }
  }

  void enable() {
    this.btnElement.disabled = false;
  }

  void disable() {
    this.btnElement.disabled = true;
  }
}

class PrevButton extends PathButton {
  PrevButton(ProgressPath path) : super(path, 'prev') {
    this.btnElement.addEventListener("click", (event) => path.move(-1));
  }
}

class NextButton extends PathButton {
  NextButton(ProgressPath path) : super(path, 'next') {
    this.btnElement.addEventListener("click", (event) => path.move(1));
  }
}

void main() {
  ProgressPath();
}
