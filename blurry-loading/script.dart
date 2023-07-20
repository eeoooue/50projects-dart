import 'dart:html';
import 'dart:async';

class BlurryLoader {
  int load = 0;
  Element background;
  Element loadText;

  BlurryLoader(this.loadText, this.background) {
    var interval = Duration(milliseconds: 30);

    Timer.periodic(interval, (timer) {
      this.blurring();
    });
  }

  void blurring() {
    if (this.load > 99) {
      return;
    }

    this.load += 1;
    this.loadText.innerText = "${this.load}%";

    double opacityValue = 1 - (this.load / 100);
    this.loadText.style.opacity = "${opacityValue}";

    double filterValue = 30 - ((this.load / 100) * 30);
    background.style.filter = "blur(${filterValue}px)";
  }
}

void main() {
  Element? loadText = document.querySelector('.loading-text');
  Element? bg = document.querySelector('.bg');

  if (loadText != null && bg != null) {
    BlurryLoader(loadText, bg);
  }
}
