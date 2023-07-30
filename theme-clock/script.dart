import 'dart:html';
import 'dart:async';

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

class ThemeClock {
  List<TimeElement> elements = List.empty(growable: true);
  TimeKeeper keeper = TimeKeeper();

  ThemeClock() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateAll();
    });
  }

  void includeElement(TimeElement element) {
    if (!elements.contains(element)) {
      elements.add(element);
    }
  }

  void updateAll() {
    keeper.updateTime();
    for (TimeElement element in elements) {
      element.update(keeper);
    }
  }

  void armToggle() {
    // Element? toggle = document.querySelector('.toggle');
  }
}

abstract class TimeElement {
  void update(TimeKeeper time) {}
}

class TimeKeeper {
  String month = "";
  int day = 0;
  String weekday = "";

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  List<String> months = List.from({
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  });

  List<String> weekdays = List.from({
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  });

  TimeKeeper() {}

  void updateTime() {
    var now = DateTime.now();

    month = months[now.month - 1];
    day = now.day;
    weekday = weekdays[now.weekday - 1];

    hours = now.hour;
    minutes = now.minute;
    seconds = now.second;
  }

  int getClockHour() {
    return (hours > 12) ? hours % 12 : hours;
  }

  String getAmPm() {
    return (hours < 12) ? "AM" : "PM";
  }

  String getClockMins() {
    if (minutes < 10) {
      return "0${minutes}";
    }

    return minutes.toString();
  }
}

class DateTimeDisplay extends TimeElement {
  Element dateEl;
  Element timeEl;

  DateTimeDisplay(this.dateEl, this.timeEl) {}

  void update(TimeKeeper time) {
    updateDate(time);
    updateTime(time);
  }

  void updateDate(TimeKeeper time) {
    var newHtml =
        '${time.weekday}, ${time.month} <span class="circle">${time.day}</span>';
    dateEl.setInnerHtml(newHtml, validator: AllowAll());
  }

  void updateTime(TimeKeeper time) {
    var newHtml =
        '${time.getClockHour()}:${time.getClockMins()} ${time.getAmPm()}';
    timeEl.setInnerHtml(newHtml, validator: AllowAll());
  }
}

class ClockDisplay extends TimeElement {
  Element hourEl;
  Element minuteEl;
  Element secondEl;

  ClockDisplay(this.hourEl, this.minuteEl, this.secondEl) {}

  void update(TimeKeeper time) {}
}

void main() {
  ThemeClock themeClock = ThemeClock();

  Element? hourEl = document.querySelector('.hour');
  Element? minuteEl = document.querySelector('.minute');
  Element? secondEl = document.querySelector('.second');

  if (hourEl is Element && minuteEl is Element && secondEl is Element) {
    final clock = ClockDisplay(hourEl, minuteEl, secondEl);
    themeClock.includeElement(clock);
  }

  Element? dateEl = document.querySelector('.date');
  Element? timeEl = document.querySelector('.time');

  if (dateEl is Element && timeEl is Element) {
    final dateTimeDisplay = DateTimeDisplay(dateEl, timeEl);
    themeClock.includeElement(dateTimeDisplay);
  }
}
