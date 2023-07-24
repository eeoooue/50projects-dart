import 'dart:html';
import 'dart:math';
import 'dart:async';

class MessageDealer {
  Random randomizer = Random();
  List<String> messages = [
    'Message One',
    'Message Two',
    'Message Three',
    'Message Four',
  ];
  List<String> types = ['info', 'success', 'error'];

  MessageDealer() {}

  String getRandomMessage() {
    int n = messages.length;
    int i = randomizer.nextInt(n);
    return messages[i];
  }

  String getRandomType() {
    int n = types.length;
    int i = randomizer.nextInt(n);
    return types[i];
  }
}

void main() {
  Element? button = document.getElementById('button');

  final dealer = MessageDealer();

  button?.addEventListener("click", (event) {
    createNotification(dealer);
  });
}

void createNotification(MessageDealer dealer) {
  String message = dealer.getRandomMessage();
  String type = dealer.getRandomType();
  Element toast = createToast(message, type);
  displayToast(toast);
}

void displayToast(Element toast) {
  Element? container = document.getElementById('toasts');

  if (container is Element) {
    container.children.add(toast);
    Timer(Duration(seconds: 3), () {
      toast.remove();
    });
  }
}

Element createToast(String message, String type) {
  Element notif = document.createElement('div');

  notif.classes.add('toast');
  notif.classes.add(type);

  notif.innerText = message;

  return notif;
}
