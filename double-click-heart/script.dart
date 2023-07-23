import 'dart:html';
import 'dart:async';

class SocialElement {
  int clickTime = 0;
  int timesClicked = 0;

  Element element;
  SpanElement times;

  SocialElement(this.element, this.times) {
    element.addEventListener("click", (event) {
      if (event is MouseEvent) {
        processMouseClick(event);
      }
    });
  }

  void processMouseClick(MouseEvent event) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    if (clickTime != 0) {
      if (currentTime - clickTime < 800) {
        submitLikeEvent(event);
      }
    }

    clickTime = currentTime;
  }

  void submitLikeEvent(MouseEvent event) {
    Element heart = createHeart(event);
    element.children.add(heart);
    addClick();
    new Timer(Duration(seconds: 1), () {
      heart.remove();
    });
  }

  void addClick() {
    timesClicked += 1;
    times.text = timesClicked.toString();
  }

  Element createHeart(MouseEvent event) {
    Element heart = document.createElement("i");
    heart.classes.add('fas');
    heart.classes.add('fa-heart');

    heart.style.top = "${event.offset.y}px";
    heart.style.left = "${event.offset.x}px";

    return heart;
  }
}

void main() {
  var loveMe = document.querySelector('.loveMe');
  var times = document.getElementById('times');

  if (loveMe is Element && times is SpanElement) {
    SocialElement(loveMe, times);
  }
}
