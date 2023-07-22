import 'dart:html';

void main() {
  window.addEventListener('scroll', (event) {
    fixNav();
  });
}

void fixNav() {
  var nav = document.querySelector('.nav');

  if (nav == null) {
    return;
  }

  if (window.scrollY > nav.offsetHeight + 150) {
    nav.classes.add('active');
  } else {
    nav.classes.remove('active');
  }
}
