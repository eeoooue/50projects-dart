import 'dart:html';

void main() {
  final contents = document.querySelectorAll('.content');
  final listItems = document.querySelectorAll('nav ul li');

  for (int i = 0; i < listItems.length; i++) {
    Element item = listItems[i];

    item.addEventListener("click", (event) {
      hideAllContents();
      hideAllItems();
      item.classes.add("active");
      contents[i].classes.add("show");
    });
  }
}

void hideAllContents() {
  final contents = document.querySelectorAll('.content');
  for (Element e in contents) {
    e.classes.remove('show');
  }
}

void hideAllItems() {
  final listItems = document.querySelectorAll('nav ul li');
  for (Element item in listItems) {
    item.classes.remove('active');
  }
}
