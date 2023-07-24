import 'dart:html';

class CustomSlider {
  RangeInputElement range;
  LabelElement label;
  final int min;
  final int max;

  CustomSlider(this.range, this.label, this.min, this.max) {
    range.addEventListener("input", (event) {
      updateLabel();
    });
  }

  double getRangeValue() {
    return double.parse(range.value!);
  }

  void updateLabel() {
    double value = getRangeValue();
    String roundedVal = (value ~/ 1).toString();
    double left = calculatePosition(value);

    label.setInnerHtml(roundedVal);
    label.style.left = "${left}px";
  }

  double calculatePosition(double value) {
    double range_width = getRangeWidth();
    double label_width = getLabelWidth();

    double left = value * (range_width / max) -
        label_width / 2 +
        scale(value, min, max, 10, -10);

    return left;
  }

  double getRangeWidth() {
    String widthValue = range.getComputedStyle().getPropertyValue("width");
    return unpackPixels(widthValue);
  }

  double getLabelWidth() {
    String widthValue = label.getComputedStyle().getPropertyValue("width");
    return unpackPixels(widthValue);
  }

  double unpackPixels(String styleValue) {
    String cropped = styleValue.substring(0, styleValue.length - 2);
    return double.parse(cropped);
  }
}

void main() {
  Element? range = document.getElementById('range');
  Element? label = range?.nextElementSibling;

  if (range is RangeInputElement && label is LabelElement) {
    int min = int.parse(range.min!);
    int max = int.parse(range.max!);

    CustomSlider(range, label, min, max);
  }
}

double scale(double val, int inLo, int inHi, int outLo, int outHi) {
  int inRange = inHi - inLo;
  double fraction = val / inRange;
  int outRange = outHi - outLo;

  return outLo + (fraction * outRange);
}
