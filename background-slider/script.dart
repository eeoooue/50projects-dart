import 'dart:html';

class Slideshow {
  int i = 0;
  BodyElement body = document.body!;
  ElementList<Element> slides = document.querySelectorAll('.slide');

  ButtonElement left;
  ButtonElement right;

  Slideshow(this.left, this.right) {
    left.addEventListener("click", (event) {
      changeSlide(-1);
    });

    right.addEventListener("click", (event) {
      changeSlide(1);
    });

    changeSlide(0);
  }

  void changeSlide(int amount) {
    i = (slides.length + i + amount) % slides.length;
    updateActiveSlide();
    updateBackground();
  }

  void updateBackground() {
    body.style.backgroundImage = slides[i].style.backgroundImage;
  }

  void updateActiveSlide() {
    for (Element slide in slides) {
      slide.classes.remove("active");
    }

    slides[i].classes.add("active");
  }
}

void main() {
  var leftBtn = document.getElementById('left');
  var rightBtn = document.getElementById('right');

  if (leftBtn is ButtonElement && rightBtn is ButtonElement) {
    Slideshow(leftBtn, rightBtn);
  }
}
