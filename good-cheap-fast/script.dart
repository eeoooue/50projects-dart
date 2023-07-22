import 'dart:html';
import 'dart:collection';

class OptionManager {
  int limit = 0;
  int active = 0;
  final queue = Queue<OptionWidget>();

  OptionManager() {
    ElementList<Element> toggles = document.querySelectorAll('.toggle');
    limit = toggles.length;

    for (Element toggle in toggles) {
      if (toggle is CheckboxInputElement) {
        OptionWidget(this, toggle);
      }
    }
  }

  void notify(OptionWidget widget) {
    CheckboxInputElement checkbox = widget.element;
    if (checkbox.checked == true) {
      active += 1;
      queue.add(widget);
      if (active >= limit) {
        deactivateOldest();
      }
    } else {
      queue.remove(widget);
      active -= 1;
    }
  }

  void deactivateOldest() {
    OptionWidget widget = queue.removeFirst();
    if (widget.element.checked == true) {
      widget.element.checked = false;
      active -= 1;
      return;
    }
    deactivateOldest();
  }
}

class OptionWidget {
  CheckboxInputElement element;

  OptionWidget(OptionManager manager, this.element) {
    element.addEventListener('change', (event) {
      manager.notify(this);
    });
  }
}

void main() {
  OptionManager();
}
