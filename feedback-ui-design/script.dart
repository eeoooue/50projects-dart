import 'dart:html';

class AllowAll implements NodeValidator {
  @override
  bool allowsAttribute(Element element, String attributeName, String value) {
    return true;
  }

  @override
  bool allowsElement(Element element) {
    return true;
  }
}

class FeedbackPanel {
  String selectedRating = 'Satisfied';

  Element container;
  List<FeedbackOption> options = List.empty(growable: true);
  Element sendBtn;

  FeedbackPanel(this.container, this.sendBtn) {
    List<Element> ratings = document.querySelectorAll('.rating');

    for (Element rating in ratings) {
      Element? sibling = rating.querySelector("img");
      Element? small = rating.querySelector("small");

      if (sibling is Element && small is Element) {
        FeedbackOption option = FeedbackOption(this, rating, sibling, small);
        options.add(option);
      }
    }

    sendBtn.addEventListener("click", (event) => thankUser());
  }

  void deactivateOptions() {
    for (FeedbackOption option in options) {
      option.deactivate();
    }
  }

  void updateChoice(String choice) {
    selectedRating = choice;
  }

  void thankUser() {
    var panel = document.querySelector('#panel');

    StringBuffer buffer = StringBuffer();
    buffer.write("<i class='fas fa-heart'></i><strong>Thank You!</strong><br>");
    buffer.write("<strong>Feedback: ${selectedRating}</strong><p>");
    buffer.write("We'll use your feedback to improve our customer support</p>");

    panel?.setInnerHtml(buffer.toString(), validator: AllowAll());
  }
}

class FeedbackOption {
  FeedbackPanel parent;
  Element element;
  Element imageElement;
  Element small;

  FeedbackOption(this.parent, this.element, this.imageElement, this.small) {
    element.addEventListener("click", (event) => activate());
  }

  void activate() {
    parent.deactivateOptions();
    element.classes.add("active");
    parent.updateChoice(small.innerText);
  }

  void deactivate() {
    element.classes.remove("active");
  }
}

void main() {
  Element? container = document.querySelector('.ratings-container');
  Element? sendBtn = document.querySelector('#send');

  if (container is Element && sendBtn is Element) {
    FeedbackPanel(container, sendBtn);
  }
}
