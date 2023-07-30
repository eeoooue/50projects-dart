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

class Notebook {
  String key = "notebook";
  ButtonElement addBtn;

  List<NoteElement> notes = List.empty(growable: true);

  Notebook(this.addBtn) {
    initialize();
    addBtn.addEventListener("click", (event) => createNote(""));
  }

  void initialize() {
    String? data = window.localStorage[key];

    print("attempted to initialize: data = ${data}");

    if (data is String) {
      List<String> noteStrings = unpackStrings(data);
      for (String text in noteStrings) {
        createNote(text);
        print("attempted to create note with seed = ${text}");
      }
    }
  }

  List<String> unpackStrings(String list) {
    List<String> result = List.empty(growable: true);

    for (String note in list.split(",")) {
      if (note.length > 1) {
        result.add(note);
      }
    }

    return result;
  }

  void update() {
    print("notes is ${notes.length} long");

    List<String> noteStrings = List.empty(growable: true);
    for (NoteElement note in notes) {
      noteStrings.add(note.text);
      print("added ${note.text} to the list");
    }

    String data = encodeList(noteStrings);
    window.localStorage[key] = data;

    print("updated local storage");
  }

  String encodeList(List<String> strings) {
    StringBuffer buffer = StringBuffer();

    for (String s in strings) {
      buffer.write(s);
      buffer.write(",");
    }

    return buffer.toString();
  }

  void createNote(String text) {
    var note = NoteElement(this, text);
    notes.add(note);

    print("added note -- notes is ${notes.length} long");
    update();
  }

  void removeNote(NoteElement note) {
    this.notes.remove(note);
    update();
  }
}

class NoteElement {
  Notebook parent;
  Element element = document.createElement('div');
  String text;

  NoteElement(this.parent, this.text) {
    element.classes.add("note");
    setupElement();
    document.body?.children.add(element);

    if (text.length == 0) {
      var textArea = element.querySelector('textarea');

      if (textArea is TextAreaElement) {
        textArea.focus();
      }
    }
  }

  void updateText() {
    var main = element.querySelector('.main');
    if (main is Element) {
      main.innerText = text;
    }

    var textArea = element.querySelector('textarea');
    if (textArea is TextInputElement) {
      textArea.value = text;
    }

    parent.update();
  }

  void toggleEditable() {
    var main = element.querySelector('.main');
    var textArea = element.querySelector('textarea');

    if (main is Element && textArea is Element) {
      main.classes.toggle("hidden");
      textArea.classes.toggle("hidden");
    }
  }

  void setupElement() {
    StringBuffer buffer = StringBuffer();

    // creates an editable note

    buffer.write('<div class="tools">');
    buffer.write('<button class="edit"><i class="fas fa-edit"></i></button>');
    buffer.write(
        '<button class="delete"><i class="fas fa-trash-alt"></i></button>');
    buffer.write('</div>');
    buffer.write('<div class="main hidden"></div>');
    buffer.write('<textarea></textarea>');

    String newHtml = buffer.toString();

    element.setInnerHtml(newHtml, validator: AllowAll());

    if (text.length > 0) {
      toggleEditable();
    }

    addBtns();

    var textArea = element.querySelector('textarea');

    if (textArea is TextAreaElement) {
      textArea.value = text;
      textArea.addEventListener("input", (event) {
        text = textArea.value!;
        updateText();
      });
    }

    updateText();
  }

  void addBtns() {
    var editBtn = element.querySelector('.edit');

    if (editBtn is ButtonElement) {
      NoteEditBtn(this, editBtn);
    }

    var deleteBtn = element.querySelector('.delete');

    if (deleteBtn is ButtonElement) {
      NoteDelBtn(this, deleteBtn);
    }
  }

  void delete() {
    element.remove();
    parent.removeNote(this);
  }
}

class NoteEditBtn {
  NoteElement parent;
  ButtonElement element;

  NoteEditBtn(this.parent, this.element) {
    element.addEventListener("click", (event) {
      parent.toggleEditable();
    });
  }
}

class NoteDelBtn {
  NoteElement parent;
  ButtonElement element;

  NoteDelBtn(this.parent, this.element) {
    element.addEventListener("click", (event) {
      parent.delete();
    });
  }
}

void main() {
  var addBtn = document.getElementById('add');

  if (addBtn is ButtonElement) {
    Notebook(addBtn);
  }
}
