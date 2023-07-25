import 'dart:html';
import 'dart:async';

class IncrementingCounter {
  Element element;
  int value = 0;

  IncrementingCounter(this.element) {
    // updateText();
    incrementCounter();
  }

  int getTarget() {
    String? target = element.getAttribute("data-target");

    if (target is String) {
      return int.parse(target);
    }

    return 0;
  }

  void updateText() {
    element.innerText = value.toString();
  }

  void incrementCounter() {
    int target = getTarget();
    int amount = target ~/ 200;

    value += amount;

    if (value > target) {
      value = target;
    }

    updateText();

    if (value != target) {
      Timer(Duration(milliseconds: 1), () {
        incrementCounter();
      });
    }
  }
}

void main() {
  var counters = document.querySelectorAll(".counter");
  for (Element counter in counters) {
    IncrementingCounter(counter);
  }
}
