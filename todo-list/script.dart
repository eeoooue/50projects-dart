import 'dart:html';

class StorageSystem {
  String key = "todolist";
  StorageSystem() {}

  List<String> getList() {
    String? data = window.localStorage[key];

    if (data is String) {
      return decodeString(data);
    }

    return List.empty(growable: true);
  }

  void saveList(List<String> strings) {
    String data = encodeStrings(strings);
    window.localStorage[key] = data;
  }

  String encodeStrings(List<String> strings) {
    StringBuffer buffer = StringBuffer();
    for (String s in strings) {
      buffer.write("${s},");
    }

    return buffer.toString();
  }

  List<String> decodeString(String encoded) {
    List<String> result = List.empty(growable: true);

    for (String s in encoded.split(",")) {
      if (s.length > 0) {
        result.add(s);
      }
    }

    return result;
  }
}

class TodoList {
  FormElement form;
  TextInputElement input;
  Element container;
  StorageSystem storage = StorageSystem();
  List<TodoTask> tasks = List.empty(growable: true);

  TodoList(this.form, this.input, this.container) {
    initialize();

    form.addEventListener("submit", (event) {
      String? text = input.value;
      if (text is String) {
        createTask(text);
      }
      input.value = "";
    });
  }

  void initialize() {
    List<String> tasks = storage.getList();

    for (String taskData in tasks) {
      TodoTask task = processTaskData(taskData);
      appendTask(task);
    }
  }

  TodoTask processTaskData(String data) {
    bool completed = (data[1] == "x");
    String text = data.substring(3);
    return TodoTask(this, text, completed);
  }

  void appendTask(TodoTask task) {
    tasks.add(task);
    container.children.add(task.element);
  }

  void createTask(String text) {
    TodoTask task = TodoTask(this, text, false);
    appendTask(task);
    update();
  }

  void deleteTask(TodoTask task) {
    task.element.remove();
    tasks.remove(task);
    update();
  }

  String encodeTask(TodoTask task) {
    String x = (task.completed) ? "x" : "o";
    return "[${x}]${task.text}";
  }

  void update() {
    List<String> list = List.empty(growable: true);
    for (TodoTask task in tasks) {
      String encoding = encodeTask(task);
      list.add(encoding);
    }

    storage.saveList(list);
  }
}

class TodoTask {
  TodoList parent;
  String text;
  late Element element;
  bool completed;

  TodoTask(this.parent, this.text, this.completed) {
    element = createElement();

    element.addEventListener("click", (event) => toggleComplete());
    element.addEventListener("contextmenu", (event) {
      event.preventDefault();
      delete();
    });
  }

  void toggleComplete() {
    element.classes.toggle("completed");
    completed = element.classes.contains("completed");
    parent.update();
  }

  void delete() {
    parent.deleteTask(this);
  }

  Element createElement() {
    Element li = document.createElement("li");
    li.classes.add("todo");
    li.innerText = text;

    if (completed) {
      li.classes.add("completed");
    }

    return li;
  }
}

void main() {
  var form = document.getElementById('form');
  var input = document.getElementById('input');
  var todosUL = document.getElementById('todos');

  if (form is FormElement && input is TextInputElement) {
    if (todosUL is Element) {
      TodoList(form, input, todosUL);
    }
  }
}
