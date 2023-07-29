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

class SearchWidget {
  ProfileViewer parent;
  Element element;
  TextInputElement textInput;

  SearchWidget(this.parent, this.element, this.textInput) {
    element.addEventListener("submit", (event) {
      event.preventDefault();
      String? username = textInput.value;

      if (username is String) {
        parent.getUser(username);
        textInput.value = "";
      }
    });
  }
}

class UserStats {
  int publicRepos;
  int followers;
  int following;

  UserStats(this.publicRepos, this.followers, this.following) {}
}

class UserProfile {
  String name;
  UserStats stats;
  String userName;

  String avatarUrl = "";
  String bio = "";
  List<UserRepo> repos = List.empty(growable: true);

  UserProfile(this.userName, this.name, this.stats) {}

  void setAvatarUrl(String? urlAddress) {
    if (urlAddress != null) {
      avatarUrl = urlAddress;
    }
  }

  void setBio(String? data) {
    if (data != null) {
      bio = data;
    }
  }

  Future<Element> createElement() async {
    Element card = document.createElement("div");
    card.classes.add("card");

    StringBuffer buffer = StringBuffer();

    buffer.write('<div>');
    buffer.write('<img src="${avatarUrl}" alt="${name}" class="avatar">');
    buffer.write('</div>');

    buffer.write('<div class="user-info">');
    buffer.write('<h2>${name}</h2>');
    buffer.write('${bio}');
    buffer.write('<ul>');
    buffer.write('<li>${stats.followers} <strong>Followers</strong></li>');
    buffer.write('<li>${stats.following} <strong>Following</strong></li>');
    buffer.write('<li>${stats.publicRepos} <strong>Repos</strong></li>');
    buffer.write('</ul>');

    buffer.write('<div id="repos" class="repo-list"></div>');
    buffer.write('</div>');

    card.setInnerHtml(buffer.toString(), validator: AllowAll());
    await deriveRepos();
    addReposToCard(card);

    return card;
  }

  Future<void> deriveRepos() async {
    final url = "https://api.github.com/users/${userName}/repos?sort=created";
    final response = await HttpRequest.getString(url);
    final data = await json.decode(response);

    for (dynamic item in data) {
      String? repoName = item['name'];
      String? repoUrl = item['html_url'];

      if (repoName != null && repoUrl != null) {
        UserRepo repo = UserRepo(repoName, repoUrl);
        repos.add(repo);

        if (repos.length >= 5) {
          break;
        }
      }
    }
  }

  void addReposToCard(Element card) async {
    Element? container = card.querySelector(".repo-list");
    container?.children.clear();

    for (UserRepo repo in repos) {
      container?.children.add(repo.createElement());
    }

    print("added repos to card");
  }
}

class UserRepo {
  String name;
  String url;

  UserRepo(this.name, this.url) {}

  Element createElement() {
    Element el = document.createElement('a');
    el.classes.add("repo");

    if (el is AnchorElement) {
      el.href = url;
    }

    el.innerText = name;

    return el;
  }
}

class ProfileViewer {
  Element element;
  UserProfile? currentProfile = null;

  ProfileViewer(this.element) {
    refresh();
  }

  refresh() async {
    element.children.clear();

    if (currentProfile is UserProfile) {
      Element? card = await currentProfile?.createElement();
      if (card != null) {
        element.children.add(card);
      }
    }
  }

  Future<void> getUser(String username) async {
    final url = "https://api.github.com/users/${username}";
    final response = await HttpRequest.getString(url);
    final data = await json.decode(response);

    String? name = data['name'];
    if (name == null) {
      name = data['login'];
    }

    if (name != null) {
      UserStats stats = deriveUserStats(data);
      UserProfile profile = UserProfile(username, name, stats);
      profile.setAvatarUrl(data['avatar_url']);
      profile.setBio(data['bio']);

      currentProfile = profile;
      refresh();
    }
  }

  UserStats deriveUserStats(dynamic user) {
    int? followers = user['followers'];
    int? following = user['following'];
    int? publicRepos = user['public_repos'];

    if (followers is int && following is int && publicRepos is int) {
      return UserStats(publicRepos, followers, following);
    }

    return UserStats(0, 0, 0);
  }
}

void main() {
  var main = document.getElementById('main');
  var form = document.getElementById('form');
  var search = document.getElementById('search');

  if (main is Element) {
    final viewer = ProfileViewer(main);

    if (form is Element && search is TextInputElement) {
      print("created widget");
      SearchWidget(viewer, form, search);
    }
  }
}
