import 'dart:html';

void main() {
  Element? search = document.querySelector('.search');
  Element? btn = document.querySelector('.btn');
  Element? input = document.querySelector('.input');

  btn?.addEventListener('click', (event) {
    search?.classes.toggle('active');
    input?.focus();
  });
}
