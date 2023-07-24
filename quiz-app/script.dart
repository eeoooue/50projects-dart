import 'dart:html';
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

class Question {
  String question;
  List<String> options = List.empty(growable: true);
  int answerIndex;

  Question(this.question, this.options, this.answerIndex) {}
}

class QuizManager {
  List<OptionWidget> optionWidgets = List.empty(growable: true);
  List<Question> questions;

  int currentQuestion = 0;
  int score = 0;

  Element container;
  ButtonElement submitBtn;

  QuizManager(this.container, this.questions, this.submitBtn) {
    makeWidgets();
    LoadQuestion(getCurrentQuestion());

    submitBtn.addEventListener("click", (event) => submit());
  }

  void makeWidgets() {
    List<Element> boxes = document.querySelectorAll('.answer');
    List<Element> labels = document.querySelectorAll(".question-holder");

    int n = min(boxes.length, labels.length);

    for (int i = 0; i < n; i++) {
      Element element = boxes[i];
      Element label = labels[i];

      if (element is CheckboxInputElement && label is LabelElement) {
        OptionWidget widget = OptionWidget(element, label);
        optionWidgets.add(widget);
      }
    }
  }

  int getSelectedIndex() {
    for (int i = 0; i < optionWidgets.length; i++) {
      OptionWidget widget = optionWidgets[i];
      if (widget.element.checked == true) {
        return i;
      }
    }

    return -1;
  }

  Question getCurrentQuestion() {
    return questions[currentQuestion];
  }

  void LoadQuestion(Question question) {
    var questionEl = document.getElementById('question');

    if (questionEl is Element) {
      questionEl.innerText = question.question;
    }

    int n = min(question.options.length, optionWidgets.length);

    for (int i = 0; i < n; i++) {
      optionWidgets[i].updateText(question.options[i]);
    }
  }

  bool answeredCorrectly() {
    Question question = getCurrentQuestion();
    return question.answerIndex == getSelectedIndex();
  }

  void submit() {
    if (answeredCorrectly()) {
      score += 1;
    }

    currentQuestion += 1;

    if (currentQuestion < questions.length) {
      LoadQuestion(getCurrentQuestion());
    } else {
      ConcludeQuiz();
    }
  }

  void ConcludeQuiz() {
    StringBuffer buffer = StringBuffer();
    int n = questions.length;

    buffer.write("<h2>You answered ${score}/${n} questions correctly</h2>");
    buffer.write('<button onclick="location.reload()">Reload</button>');

    String newHtml = buffer.toString();
    container.setInnerHtml(newHtml, validator: AllowAll());
  }
}

class OptionWidget {
  CheckboxInputElement element;
  LabelElement label;

  OptionWidget(this.element, this.label) {}

  void updateText(String optionText) {
    element.checked = false;
    label.text = optionText;
  }
}

void main() {
  var quiz = document.getElementById('quiz');
  List<Question> questions = getQuestions();
  var submitBtn = document.getElementById('submit');

  if (quiz is Element && submitBtn is ButtonElement) {
    QuizManager(quiz, questions, submitBtn);
  }
}

List<Question> getQuestions() {
  List<Question> questions = List.empty(growable: true);

  String q1q = "Which language runs in a web browser?";
  List<String> q1o = ["Java", "C", "Python", "JavaScript"];
  Question q1 = Question(q1q, q1o, 3);
  questions.add(q1);

  String q2q = "What does CSS stand for?";
  List<String> q2o = [
    "Central Style Sheets",
    "Cascading Style Sheets",
    "Cascading Simple Sheets",
    "Cars SUVs Sailboats"
  ];
  Question q2 = Question(q2q, q2o, 1);
  questions.add(q2);

  String q3q = "What does HTML stand for?";
  List<String> q3o = [
    "Hypertext Markup Language",
    "Hypertext Markdown Language",
    "Hyperloop Machine Language",
    "Helicopters Terminals Motorboats Lamborginis"
  ];
  Question q3 = Question(q3q, q3o, 0);
  questions.add(q3);

  String q4q = "What year was JavaScript launched?";
  List<String> q4o = ["1996", "1995", "1994", "none of the above"];
  Question q4 = Question(q4q, q4o, 1);
  questions.add(q4);

  return questions;
}
