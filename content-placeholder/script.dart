import 'dart:html';
import 'dart:async';

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
  Timer(Duration(milliseconds: 2500), () {
    getData();
  });
}

void getData() {
  var animated_bgs = document.querySelectorAll('.animated-bg');
  var animated_bg_texts = document.querySelectorAll('.animated-bg-text');

  Element? header = document.getElementById('header');
  Element? title = document.getElementById('title');
  Element? excerpt = document.getElementById('excerpt');
  Element? profile_img = document.getElementById('profile_img');
  Element? name = document.getElementById('name');
  Element? date = document.getElementById('date');

  String headerHtml =
      '<img src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80" alt="" />';
  header?.setInnerHtml(headerHtml, validator: AllowAll());

  String imgHtml =
      '<img src="https://randomuser.me/api/portraits/men/45.jpg" alt="" />';
  profile_img?.setInnerHtml(imgHtml, validator: AllowAll());

  title?.setInnerHtml('Lorem ipsum dolor sit amet');
  excerpt?.setInnerHtml(
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolore perferendis');

  name?.setInnerHtml('John Doe');
  date?.setInnerHtml('Oct 08, 2020');

  for (Element e in animated_bgs) {
    e.classes.remove('animated-bg');
  }

  for (Element e in animated_bg_texts) {
    e.classes.remove('animated-bg-text');
  }
}
