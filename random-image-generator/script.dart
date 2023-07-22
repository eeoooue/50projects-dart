import 'dart:html';
import 'dart:math';

class UnsplashFacade {
  final String unsplashURL = 'https://source.unsplash.com/random/';
  final Random randomizer = Random();

  ImageElement getRandomImage() {
    Element img = document.createElement('img');
    if (img is ImageElement) {
      img.src = "${unsplashURL}${getRandomSize()}";
      return img;
    }

    return getRandomImage();
  }

  String getRandomSize() {
    return "${getRandomLength()}x${getRandomLength()}";
  }

  int getRandomLength() {
    return randomizer.nextInt(10) + 300;
  }
}

void main() {
  Element? container = document.querySelector('.container');

  if (container != null) {
    final unsplash = UnsplashFacade();

    int rowCount = 5;
    for (int i = 0; i < rowCount * 3; i++) {
      Element img = unsplash.getRandomImage();
      container.children.add(img);
    }
  }
}
