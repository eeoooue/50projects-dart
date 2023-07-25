import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JokeSystem {
  Element element;
  ButtonElement button;
  JokeSystem(this.element, this.button) {
    button.addEventListener("click", (event) => generateJoke());
    generateJoke();
  }

  Future<void> generateJoke() async {
    final config = {
      'headers': {
        'Accept': 'application/json',
      },
    };

    final res = await http.get(Uri.parse('https://icanhazdadjoke.com'),
        headers: config['headers']);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      element.innerText = data['joke'];
    }
  }
}

void main() {
  Element? jokeEl = document.getElementById('joke');
  Element? jokeBtn = document.getElementById('jokeBtn');

  if (jokeEl is Element && jokeBtn is ButtonElement) {
    JokeSystem(jokeEl, jokeBtn);
  }
}
