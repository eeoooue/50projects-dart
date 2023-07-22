import 'dart:html';
import 'dart:async';

class ImageCarousel {
  int position = 0;
  final images = document.querySelectorAll('#imgs img');

  Timer? timer;

  ImageCarousel() {
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      this.rotateBy(1);
    });
  }

  void changeImage() {
    var imgs = document.getElementById('imgs');

    if (position > images.length - 1) {
      position = 0;
    } else if (position < 0) {
      position = images.length - 1;
    }

    imgs?.style.transform = "translateX(${-position * 500}px)";
  }

  void rotateBy(int amount) {
    position += amount;
    changeImage();
    startTimer();
  }
}

class DirectionalBtn {
  DirectionalBtn(ImageCarousel carousel, Element element, int change) {
    element.addEventListener("click", (event) {
      carousel.rotateBy(change);
    });
  }
}

void main() {
  ImageCarousel carousel = ImageCarousel();

  final leftBtn = document.getElementById('left');
  if (leftBtn != null) {
    DirectionalBtn(carousel, leftBtn, -1);
  }

  final rightBtn = document.getElementById('right');
  if (rightBtn != null) {
    DirectionalBtn(carousel, rightBtn, 1);
  }
}
