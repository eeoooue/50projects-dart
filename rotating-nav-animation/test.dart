import 'dart:html';

class RotatingNav {
  Element openBtn;
  Element closeBtn;
  Element container;

  RotatingNav(this.openBtn, this.closeBtn, this.container) {
    setupOpenBtn();
    setupCloseBtn();
  }

  void setupOpenBtn() {
    this.openBtn.addEventListener("click", (event) {
      this.container.classes.add("show-nav");
    });
  }

  void setupCloseBtn() {
    this.closeBtn.addEventListener("click", (event) {
      this.container.classes.remove("show-nav");
    });
  }
}

void main() {
  Element? openBtn = document.getElementById('open');
  Element? closeBtn = document.getElementById('close');
  Element? container = document.querySelector('.container');

  if (openBtn != null && closeBtn != null && container != null) {
    RotatingNav(openBtn, closeBtn, container);
  }
}
