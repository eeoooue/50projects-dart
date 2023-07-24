import 'dart:html';

class DoubleSlider {
  Element slideLeft;
  Element slideRight;
  ButtonElement up;
  ButtonElement down;

  int activeSlide = 0;
  int slideCount = 0;

  DoubleSlider(this.slideLeft, this.slideRight, this.up, this.down) {
    slideCount = slideRight.querySelectorAll('div').length;
    slideLeft.style.top = "-${(slideCount - 1) * 100}vh";

    up.addEventListener('click', (event) {
      changeSlide('up');
    });

    down.addEventListener('click', (event) {
      changeSlide('down');
    });
  }

  void changeSlide(String direction) {
    Element? sliderContainer = document.querySelector('.slider-container');

    if (sliderContainer == null) {
      return;
    }

    var sliderHeight = sliderContainer.clientHeight;

    if (direction == 'up') {
      activeSlide = (activeSlide + 1) % slideCount;
    } else {
      activeSlide -= 1;
      if (activeSlide < 0) {
        activeSlide = slideCount - 1;
      }
    }

    slideRight.style.transform = "translateY(-${activeSlide * sliderHeight}px)";
    slideLeft.style.transform = "translateY(${activeSlide * sliderHeight}px)";
  }
}

void main() {
  var slideLeft = document.querySelector('.left-slide');
  var slideRight = document.querySelector('.right-slide');
  var upButton = document.querySelector('.up-button');
  var downButton = document.querySelector('.down-button');

  if (slideLeft is Element && slideRight is Element) {
    if (upButton is ButtonElement && downButton is ButtonElement) {
      DoubleSlider(slideLeft, slideRight, upButton, downButton);
    }
  }
}
