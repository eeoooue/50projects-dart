import 'dart:html';
import 'dart:async';
import 'dart:math';

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

class InsectGame {
  Element container;
  InsectInfo enemyInfo;

  int score = 0;
  int seconds = -1;

  InsectGame(this.enemyInfo, this.container) {
    startGame();
  }

  void startGame() {
    spawnInsect();
    Timer.periodic(Duration(seconds: 1), (timer) {
      increaseTime();
    });
  }

  void increaseTime() {
    seconds += 1;
    updateTime();
  }

  void increaseScore() {
    score += 1;
    if (score >= 20) {
      displayMessage();
    }

    Element? scoreEl = document.getElementById("score");
    if (scoreEl is Element) {
      scoreEl.innerText = "Score: ${score}";
    }
  }

  void displayMessage() {
    Element? message = document.getElementById('message');

    if (message is Element) {
      message.classes.add("visible");
    }
  }

  void updateTime() {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;

    var timeEl = document.getElementById('time');

    if (timeEl is Element) {
      timeEl.innerText = "Time: ${formatTime(mins)}:${formatTime(secs)}";
    }
  }

  String formatTime(int time) {
    if (time < 10) {
      return "0${time}";
    }
    return time.toString();
  }

  void spawnInsect() {
    Element insect = enemyInfo.createInsect();

    insect.addEventListener("click", (event) {
      increaseScore();
      insect.classes.add("caught");
      addInsects();

      Timer(Duration(seconds: 2), () {
        insect.remove();
      });
    });

    container.children.add(insect);
  }

  void addInsects() {
    Timer(Duration(milliseconds: 1000), () {
      spawnInsect();
    });
    Timer(Duration(milliseconds: 1500), () {
      spawnInsect();
    });
  }
}

class InsectInfo {
  String src;
  String alt;
  Random randomizer = Random();
  int size = 200;

  InsectInfo(this.src, this.alt) {}

  Element createInsect() {
    Element insect = document.createElement("div");
    insect.classes.add("insect");

    insect.style.top = "${getRandomHeight()}px";
    insect.style.left = "${getRandomWidth()}px";

    String newHtml =
        '<img src="${src}" alt="${alt}" style="transform: rotate(${randomizer.nextInt(360)}deg)" />';
    insect.setInnerHtml(newHtml, validator: AllowAll());

    return insect;
  }

  int getRandomHeight() {
    int max = window.innerHeight! - size;
    return randomizer.nextInt(max) + (size ~/ 2);
  }

  int getRandomWidth() {
    int max = window.innerWidth! - size;
    return randomizer.nextInt(max) + (size ~/ 2);
  }
}

void main() {
  List<Element> screens = document.querySelectorAll(".screen");

  var startButton = document.getElementById('start-btn');

  if (startButton is ButtonElement) {
    startButton.addEventListener("click", (event) {
      screens[0].classes.add("up");
      getInsectChoice(screens);
    });
  }
}

void getInsectChoice(List<Element> screens) {
  List<Element> choices = document.querySelectorAll('.choose-insect-btn');

  for (Element choice in choices) {
    if (choice is ButtonElement) {
      choice.addEventListener("click", (event) {
        Element? img = choice.querySelector("img");

        if (img is ImageElement) {
          screens[1].classes.add("up");
          String alt = img.getAttribute("alt")!;
          String src = img.getAttribute("src")!;
          InsectInfo enemy = InsectInfo(src, alt);
          newGame(enemy);
        }
      });
    }
  }
}

void newGame(InsectInfo insect) {
  Element? container = document.getElementById('game-container');

  if (container is Element) {
    InsectGame(insect, container);
  }
}
