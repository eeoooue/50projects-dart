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
    addBtn.addEventListener("click", (event) => createNote(""));
  }

  void initialize() {}

  void update() {}

  void createNote(String text) {
    var note = NoteElement(this, text);
    document.body?.children.add(note.element);
  }

  void removeNote(NoteElement note) {
    this.notes.remove(note);
  }
}

class NoteElement {
  Notebook parent;
  Element element = document.createElement('div');
  String text = "";

  NoteElement(this.parent, this.text) {
    element.classes.add("note");
    setupElement();
  }

  void updateText() {
    var main = element.querySelector('.main');
    var textArea = element.querySelector('textarea');

    if (textArea is TextInputElement) {
      textArea.value = text;
    }

    if (main is Element) {
      main.innerText = text;
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

    buffer.write('<div class="tools">');
    buffer.write('<button class="edit"><i class="fas fa-edit"></i></button>');
    buffer.write(
        '<button class="delete"><i class="fas fa-trash-alt"></i></button>');
    buffer.write('</div>');
    buffer.write('<div class="main ${(text == "") ? "" : "hidden"}"></div>');
    buffer
        .write('<textarea class="${(text == "") ? "hidden" : ""}"></textarea>');

    String newHtml = buffer.toString();

    element.setInnerHtml(newHtml, validator: AllowAll());

    var textArea = element.querySelector('textarea');

    if (textArea is TextAreaElement) {
      textArea.addEventListener("input", (event) {
        text = textArea.value!;
        updateText();
      });
    }
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
