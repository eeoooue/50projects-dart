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
  var labels = document.querySelectorAll('.form-control label');
  for (Element label in labels) {
    armWaveAnimation(label);
  }
}

void armWaveAnimation(Element label) {
  StringBuffer buffer = StringBuffer();
  for (int i = 0; i < label.innerText.length; i++) {
    String x = label.innerText[i];
    buffer.write('<span style="transition-delay:${i * 50}ms">${x}</span>');
  }

  label.setInnerHtml(buffer.toString(), validator: AllowAll());
}
