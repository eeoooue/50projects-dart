import 'dart:html';

void main() {
  Element? toggle = document.getElementById('toggle');
  Element? nav = document.getElementById('nav');

  toggle?.addEventListener('click', (event) {
    nav?.classes.toggle('active');
  });
}
