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
    currentActive += change;

    if (currentActive < 1) {
      currentActive = 1;
    }

    if (currentActive > 4) {
      currentActive = 4;
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

class PrevButton {
  PrevButton(ProgressPath path) {
    var prev = document.getElementById('prev');
    prev?.addEventListener("click", (event) => path.move(-1));
  }

  void enable() {
    Element? prev = document.getElementById('prev');

    if (prev is ButtonElement) {
      ButtonElement btn = prev;
      btn.disabled = false;
    }
  }

  void disable() {
    Element? prev = document.getElementById('prev');

    if (prev is ButtonElement) {
      ButtonElement btn = prev;
      btn.disabled = true;
    }
  }
}

class NextButton {
  NextButton(ProgressPath path) {
    var next = document.getElementById('next');
    next?.addEventListener("click", (event) => path.move(1));
  }

  void enable() {
    Element? next = document.getElementById('next');

    if (next is ButtonElement) {
      ButtonElement btn = next;
      btn.disabled = false;
    }
  }

  void disable() {
    Element? next = document.getElementById('next');

    if (next is ButtonElement) {
      ButtonElement btn = next;
      btn.disabled = true;
    }
  }
}

void main() {
  ProgressPath();
}
