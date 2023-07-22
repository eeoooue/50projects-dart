import 'dart:html';

class SoundBoard {
  Element container;

  List<SoundButton> buttons = new List.empty(growable: true);

  SoundBoard(this.container) {
    List<String> soundNames = [
      'applause',
      'boo',
      'gasp',
      'tada',
      'victory',
      'wrong'
    ];

    for (String sound in soundNames) {
      var button = SoundButton(this, sound);
      buttons.add(button);
      container.append(button.element);
    }
  }

  void muteAll() {
    for (SoundButton button in buttons) {
      button.mute();
    }
  }
}

class SoundButton {
  Element element = document.createElement("button");
  String soundName;
  SoundBoard parent;

  SoundButton(this.parent, this.soundName) {
    element.classes.add("btn");
    element.innerText = soundName;

    element.addEventListener("click", (event) => play());
  }

  void play() {
    parent.muteAll();
    Element? element = document.getElementById(soundName);

    if (element is AudioElement) {
      element.play();
    }
  }

  void mute() {
    Element? element = document.getElementById(soundName);

    if (element is AudioElement) {
      element.pause();
      element.currentTime = 0;
    }
  }
}

void main() {
  Element? container = document.getElementById("buttons");

  if (container != null) {
    SoundBoard(container);
  }
}
