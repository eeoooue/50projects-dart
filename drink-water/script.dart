import 'dart:html';

void main() {
  updateBigCup();

  List<Element> smallCups = document.querySelectorAll('.cup-small');

  for (int i = 0; i < smallCups.length; i++) {
    Element cup = smallCups[i];
    cup.addEventListener("click", (event) => highlightCups(i));
  }
}

void highlightCups(clickedIndex) {
  List<Element> smallCups = document.querySelectorAll('.cup-small');

  if (smallCups[clickedIndex].classes.contains("full")) {
    clickedIndex = clickedIndex - 1;
  }

  for (int i = 0; i < smallCups.length; i++) {
    Element cup = smallCups[i];
    cup.classes.remove('full');
    if (i <= clickedIndex) {
      cup.classes.add('full');
    }
  }

  updateBigCup();
}

void updateBigCup() {
  List<Element> smallCups = document.querySelectorAll('.cup-small');

  Element? liters = document.getElementById('liters');
  Element? percentage = document.getElementById('percentage');
  Element? remained = document.getElementById('remained');

  int fullCups = document.querySelectorAll('.cup-small.full').length;
  int totalCups = smallCups.length;

  if (fullCups == 0) {
    percentage?.style.visibility = 'hidden';
    percentage?.style.height = "0";
  } else {
    percentage?.style.visibility = 'visible';
    percentage?.style.height = "${fullCups / totalCups * 330}px";
    percentage?.innerText = "${fullCups / totalCups * 100}%";
  }

  if (fullCups == totalCups) {
    remained?.style.visibility = 'hidden';
    remained?.style.height = "0";
  } else {
    remained?.style.visibility = 'visible';
    liters?.innerText = "${2 - (250 * fullCups / 1000)}L";
  }
}
