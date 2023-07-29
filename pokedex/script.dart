import 'dart:collection';
import 'dart:html';
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

class PokePalette {
  HashMap<String, String> colours = HashMap<String, String>.from({
    "fire": '#FDDFDF',
    "grass": '#DEFDE0',
    "electric": '#FCF7DE',
    "water": '#DEF3FD',
    "ground": '#f4e7da',
    "rock": '#d5d5d4',
    "fairy": '#fceaff',
    "poison": '#98d7a5',
    "bug": '#f8d5a3',
    "dragon": '#97b3e6',
    "psychic": '#eaeda1',
    "flying": '#F5F5F5',
    "fighting": '#E6E0D4',
    "normal": '#F5F5F5'
  });

  String getColour(String type) {
    String? result = colours[type];

    if (result != null) {
      return result;
    }

    return '#F5F5F5';
  }

  bool validType(String type) {
    return colours.containsKey(type);
  }
}

class Pokedex {
  List<PokemonCard> cards = List.empty(growable: true);
  Element container;
  int pokemonCount = 150;
  PokePalette palette = PokePalette();

  Pokedex(this.container) {
    loadPokedex();
  }

  void loadPokedex() async {
    cards.clear();
    for (int i = 1; i <= pokemonCount; i++) {
      await getPokemon(i);
    }

    populateElements();
  }

  Future<void> getPokemon(int id) async {
    final url = "https://pokeapi.co/api/v2/pokemon/${id}";

    final response = await HttpRequest.getString(url);
    final data = await json.decode(response);

    String name = data['name'];

    List<String> types = List.empty(growable: true);

    for (dynamic type in data['types']) {
      String typeName = type['type']['name'];
      types.add(typeName);
    }

    PokemonCard card = PokemonCard(id, name, types);
    cards.add(card);
  }

  void populateElements() {
    container.children.clear();

    for (PokemonCard card in cards) {
      container.children.add(card.createElement());
    }
  }
}

class PokemonCard {
  int id;
  String name;
  List<String> types;
  PokePalette palette = PokePalette();

  PokemonCard(this.id, this.name, this.types) {}

  Element createElement() {
    Element card = document.createElement("div");
    card.classes.add("pokemon");

    StringBuffer buffer = StringBuffer();
    String imgUrlPrefix =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/";

    String type = "normal";

    for (String option in types) {
      if (palette.validType(option)) {
        type = option;
        break;
      }
    }

    card.style.backgroundColor = palette.getColour(type);

    buffer.write('<div class="img-container">');
    buffer.write('<img src="${imgUrlPrefix}${id}.png"" alt="${name}">');
    buffer.write('</div>');

    buffer.write('<div class="info">');
    buffer.write('<span class="number">${getIdString()}</span>');
    buffer.write('<h3 class="name">${getTitle()}</h3>');
    buffer.write('<small class="type">Type: <span>${type}</span></small>');
    buffer.write('</div>');

    card.setInnerHtml(buffer.toString(), validator: AllowAll());

    return card;
  }

  String getTitle() {
    String firstLetter = name[0].toUpperCase();
    String suffix = name.substring(1);

    return "${firstLetter}${suffix}";
  }

  String getIdString() {
    String textForm = id.toString();

    while (textForm.length < 3) {
      textForm = "0" + textForm;
    }

    return "#${textForm}";
  }
}

void main() {
  var container = document.getElementById('poke-container');
  if (container is Element) {
    Pokedex(container);
  }
}
