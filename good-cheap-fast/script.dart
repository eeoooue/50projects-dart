import 'dart:html';

class OptionManager {
  int limit = 0;

  OptionManager() {
    ElementList<Element> toggles = document.querySelectorAll('.toggle');
    limit = toggles.length;

    for (Element toggle in toggles) {
      OptionWidget(this, toggle);
    }
  }
}

class OptionWidget {
  Element element;

  OptionWidget(OptionManager manager, this.element) {
    element.addEventListener('change', (event) {
      toggle();
    });
  }

  void toggle() {
    Element box = element;
    if (box is CheckboxInputElement) {
      if (box.checked != true) {
        box.checked = true;
      } else {
        box.checked = false;
      }
    }
  }
}

void main() {
  OptionManager();
}
