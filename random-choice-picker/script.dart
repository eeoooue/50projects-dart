import 'dart:html';
import 'dart:math';
import 'dart:async';

class RandomChoicePicker {
  Element tagContainer;
  TextAreaElement textArea;
  Random randomizer = Random();
  List<ChoiceTag> choices = List.empty(growable: true);
  int limit = 0;

  RandomChoicePicker(this.textArea, this.tagContainer) {
    textArea.focus();

    textArea.addEventListener('keyup', (event) {
      createTags(textArea.value!);

      if (event is KeyboardEvent) {
        if (event.key == "Enter") {
          makeSelection();
        }
      }
    });
  }

  void refreshContainer() {
    tagContainer.children.clear();

    for (ChoiceTag tag in choices) {
      tagContainer.children.add(tag.element);
    }
  }

  void createTags(String text) {
    choices.clear();
    for (String text in text.split(",")) {
      text = text.trim();
      if (text.length > 0) {
        ChoiceTag tag = ChoiceTag(text);
        choices.add(tag);
      }
    }

    refreshContainer();
  }

  void deactivateAll() {
    for (ChoiceTag tag in choices) {
      tag.deactivate();
    }
  }

  void makeSelection() {
    int n = choices.length;
    limit = (n * 3) + randomizer.nextInt(n);
    iterate(0);
  }

  void iterate(int i) {
    if (i == limit) {
      return;
    }

    deactivateAll();
    ChoiceTag tag = choices[i % choices.length];
    tag.highlight();
    Timer(Duration(milliseconds: 100), () {
      iterate(i + 1);
    });
  }
}

class ChoiceTag {
  late Element element;
  String text;

  ChoiceTag(this.text) {
    element = document.createElement("span");
    element.classes.add('tag');
    element.innerText = text;
  }

  void highlight() {
    element.classes.add("highlight");
  }

  void deactivate() {
    element.classes.remove("highlight");
  }
}

void main() {
  var tagsEl = document.getElementById('tags');
  var textarea = document.getElementById('textarea');

  if (textarea is TextAreaElement && tagsEl is Element) {
    RandomChoicePicker(textarea, tagsEl);
  }
}
