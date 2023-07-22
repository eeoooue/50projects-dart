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

void main() {
  Element? insert = document.getElementById('insert');

  if (insert != null) {
    window.addEventListener("keydown", (event) {
      if (event is KeyboardEvent) {
        displayEventKeyInfo(event, insert);
      }
    });
  }
}

void displayEventKeyInfo(KeyboardEvent event, Element insert) {
  Element keyName = createKeyDisplay(getKeyString(event), "event.key");
  Element keyCode = createKeyDisplay("${event.keyCode}", "event.keyCode");
  Element eventCode = createKeyDisplay("${event.code}", "event.code");

  insert.children.clear();
  insert.children.add(keyName);
  insert.children.add(keyCode);
  insert.children.add(eventCode);
}

Element createKeyDisplay(String innerText, String smallText) {
  Element div = document.createElement("div");
  div.classes.add("key");
  String innerHtml = "${innerText}<small>${smallText}</small>";
  div.setInnerHtml(innerHtml, validator: AllowAll());

  return div;
}

String getKeyString(KeyboardEvent event) {
  if (event.key == " ") {
    return "Space";
  }
  return event.key!;
}
