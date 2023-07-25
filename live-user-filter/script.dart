import 'dart:html';
import 'dart:async';
import 'dart:convert';

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

class UserProfile {
  String name;
  String surname;
  String imgsrc;
  String city;
  String country;
  late Element element;

  UserProfile(this.name, this.surname, this.imgsrc, this.city, this.country) {
    this.element = createListElement();
  }

  Element createListElement() {
    Element li = document.createElement('li');

    StringBuffer buffer = StringBuffer();

    buffer.write('<img src="${imgsrc}" alt="${name}">');
    buffer.write('<div class="user-info">');
    buffer.write('<h4>${name} ${surname}</h4>');
    buffer.write('<p>${city}, ${country}</p>');
    buffer.write('</div>');

    li.setInnerHtml(buffer.toString(), validator: AllowAll());

    return li;
  }

  void applyFilter(String searchTerm) {
    if (!element.classes.contains("hide")) {
      element.classes.add("hide");
    }

    if (meetsCriteria(searchTerm)) {
      element.classes.remove("hide");
    }
  }

  bool meetsCriteria(String searchTerm) {
    searchTerm = searchTerm.toLowerCase();

    for (String field in [name, surname, imgsrc, city, country]) {
      if (stringContainsTerm(field, searchTerm)) {
        return true;
      }
    }

    return false;
  }

  bool stringContainsTerm(String string, String term) {
    string = string.toLowerCase();
    term = term.toLowerCase();
    return string.contains(term);
  }
}

class DisplaySystem {
  List<UserProfile> profiles = List.empty(growable: true);

  Element container;
  TextInputElement filter;

  DisplaySystem(this.container, this.filter) {
    getData();

    filter.addEventListener('input', (event) {
      filterElements(filter.value!);
    });
  }

  Future<void> getData() async {
    String url = 'https://randomuser.me/api?results=50';
    final response = await HttpRequest.getString(url);

    final data = json.decode(response);
    final List<dynamic> results = data['results'];

    profiles.clear();

    for (dynamic user in results) {
      String name = user['name']['first'];
      String surname = user['name']['last'];
      String imgsrc = user['picture']['large'];
      String city = user['location']['city'];
      String country = user['location']['country'];

      UserProfile profile = UserProfile(name, surname, imgsrc, city, country);
      profiles.add(profile);
    }

    createElements();
  }

  void createElements() {
    container.children.clear();
    for (UserProfile profile in profiles) {
      container.children.add(profile.element);
    }
  }

  void filterElements(String searchTerm) {
    for (UserProfile profile in profiles) {
      profile.applyFilter(searchTerm);
    }
  }
}

void main() {
  var result = document.getElementById('result');
  var filter = document.getElementById('filter');

  if (result is Element && filter is TextInputElement) {
    DisplaySystem(result, filter);
  }
}
