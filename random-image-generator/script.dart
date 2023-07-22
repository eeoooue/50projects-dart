import 'dart:html';
import 'dart:math';

void main() {
  Element? container = document.querySelector('.container');
  String unsplashURL = 'https://source.unsplash.com/random/';

  int rowCount = 5;
  for (int i = 0; i < rowCount * 3; i++) {
    Element img = document.createElement('img');
    if (img is ImageElement) {
      img.src = "${unsplashURL}${getRandomSize()}";
      container?.children.add(img);
    }
  }
}

String getRandomSize() {
  return "${getRandomLength()}x${getRandomLength()}";
}

int getRandomLength() {
  Random randomizer = Random();
  return randomizer.nextInt(10) + 300;
}
