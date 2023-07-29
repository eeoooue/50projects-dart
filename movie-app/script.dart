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

class MovieApp {
  Element element;
  List<MovieCard> cards = List.empty(growable: true);

  String API_URL =
      'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=3fd2be6f0c70a2a598f084ddfb75487c&page=1';

  MovieApp(this.element) {
    getMovies(API_URL);
  }

  Future<void> getMovies(String url) async {
    final response = await HttpRequest.getString(url);
    final data = json.decode(response);

    final List<dynamic> results = data['results'];

    cards.clear();

    for (dynamic movie in results) {
      String? title = movie["title"];
      String? posterPath = movie["poster_path"];
      double? score = movie["vote_average"];
      String? overview = movie["overview"];

      if (title == null || posterPath == null) {
        continue;
      }

      if (score == null || overview == null) {
        continue;
      }

      MovieCard card = MovieCard(title, posterPath, score, overview);
      cards.add(card);
    }

    showMovies();
  }

  void showMovies() {
    element.children.clear();

    for (MovieCard card in cards) {
      element.children.add(card.element);
    }
  }
}

class MovieCard {
  String title;
  String posterPath;
  double score;
  String overview;
  late Element element;

  String IMG_PATH = 'https://image.tmdb.org/t/p/w1280';

  MovieCard(this.title, this.posterPath, this.score, this.overview) {
    this.element = createElement();
  }

  Element createElement() {
    Element card = document.createElement("div");
    card.classes.add("movie");

    StringBuffer buffer = StringBuffer();

    buffer.write('<img src="${IMG_PATH}${posterPath}" alt="${title}">');
    buffer.write('<div class="movie-info">');
    buffer.write('<h3>${title}</h3>');
    buffer.write('<span class="${deriveScoreClass()}">${score}</span>');
    buffer.write('</div>');

    buffer.write('<div class="overview">');
    buffer.write('<h3>Overview</h3>');
    buffer.write('${overview}');
    buffer.write('</div>');

    card.setInnerHtml(buffer.toString(), validator: AllowAll());

    return card;
  }

  String deriveScoreClass() {
    if (score >= 8) {
      return 'green';
    } else if (score >= 5) {
      return 'orange';
    }
    return 'red';
  }
}

class SearchWidget {
  MovieApp parent;
  Element element;
  TextInputElement textInput;

  String SEARCH_API =
      'https://api.themoviedb.org/3/search/movie?api_key=3fd2be6f0c70a2a598f084ddfb75487c&query="';

  SearchWidget(this.parent, this.element, this.textInput) {
    element.addEventListener('submit', (event) {
      event.preventDefault();
      var searchTerm = textInput.value;
      if (searchTerm is String) {
        searchMovies(searchTerm);
      }
    });
  }

  void searchMovies(String searchTerm) {
    if (searchTerm.length < 1) {
      window.location.reload();
      return;
    }
    parent.getMovies("${SEARCH_API}${searchTerm}");
  }
}

void main() {
  var main = document.getElementById('main');
  var form = document.getElementById('form');
  var search = document.getElementById('search');

  if (main is Element) {
    final app = MovieApp(main);
    if (form is Element && search is TextInputElement) {
      SearchWidget(app, form, search);
    }
  }
}
