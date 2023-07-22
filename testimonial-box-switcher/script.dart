import 'dart:collection';
import 'dart:html';
import 'dart:async';

class Testimonial {
  Client client;
  String text;

  Testimonial(this.client, this.text) {}
}

class Client {
  String name;
  String photoAddress;
  String role;

  Client(this.name, this.photoAddress, this.role) {}
}

class DisplayCard {
  Element container;

  DisplayCard(this.container) {}

  void replaceTestimonial(Testimonial testimonial) {
    setTestimonial(testimonial.text);
    final client = testimonial.client;
    setUserName(client.name);
    setRole(client.role);
    setUserImage(client.photoAddress);
  }

  void setTestimonial(String text) {
    Element? testimonial = container.querySelector('.testimonial');

    if (testimonial != null) {
      testimonial.innerText = text;
    }
  }

  void setUserImage(String photo) {
    Element? userImage = container.querySelector('.user-image');

    if (userImage is ImageElement) {
      userImage.src = photo;
    }
  }

  void setUserName(String name) {
    Element? element = container.querySelector('.username');

    if (element != null) {
      element.innerText = name;
    }
  }

  void setRole(String role) {
    Element? element = container.querySelector('.role');

    if (element != null) {
      element.innerText = role;
    }
  }
}

class DataStore {
  final Queue<Testimonial> testimonials = Queue();

  void addTestimonial(Testimonial testimonial) {
    testimonials.add(testimonial);
  }

  Testimonial getTestimonial() {
    if (testimonials.length == 0) {
      return Testimonial(Client("name", "photoAddress", "role"), "text");
    }

    Testimonial testimonial = testimonials.removeFirst();
    testimonials.add(testimonial);
    return testimonial;
  }
}

void main() {
  var container = document.querySelector('.testimonial-container');

  if (container == null) {
    return;
  }

  final display = DisplayCard(container);
  final dataStore = DataStore();
  loadTestimonials(dataStore);

  var interval = Duration(seconds: 10);

  Timer.periodic(interval, (timer) {
    var testimonial = dataStore.getTestimonial();
    display.replaceTestimonial(testimonial);
  });
}

void loadTestimonials(DataStore dataStore) {
  List<Testimonial> testimonials = fabricateTestimonials();

  for (Testimonial testimonial in testimonials) {
    dataStore.addTestimonial(testimonial);
  }
}

List<Testimonial> fabricateTestimonials() {
  List<Testimonial> result = List.empty(growable: true);

  Client jonathan = Client('Jonathan Nunfiez',
      'https://randomuser.me/api/portraits/men/43.jpg', 'Graphic Designer');
  Testimonial jonathan_testimonial = Testimonial(jonathan,
      "I had my concerns that due to a tight deadline this project can't be done. But this guy proved me wrong not only he delivered an outstanding work but he managed to deliver 1 day prior to the deadline. And when I asked for some revisions he made them in MINUTES. I'm looking forward to work with him again and I totally recommend him. Thanks again!");
  result.add(jonathan_testimonial);

  Client sasha = Client(
      'Sasha Ho',
      'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?h=350&auto=compress&cs=tinysrgb',
      'Accountant');
  Testimonial sasha_testimonial = Testimonial(sasha,
      'This guy is a top notch designer and front end developer. He communicates well, works fast and produces quality work. We have been lucky to work with him!');
  result.add(sasha_testimonial);

  Client veeti = Client('Veeti Seppanen',
      'https://randomuser.me/api/portraits/men/97.jpg', 'Director');
  Testimonial veeti_testimonial = Testimonial(veeti,
      'This guy is a young and talented IT professional, proactive and responsible, with a strong work ethic. He is very strong in PSD2HTML conversions and HTML/CSS technology. He is a quick learner, eager to learn new technologies. He is focused and has the good dynamics to achieve due dates and outstanding results.');
  result.add(veeti_testimonial);

  Client june = Client('June Cha',
      'https://randomuser.me/api/portraits/women/44.jpg', 'Software Engineer');
  Testimonial june_testimonial = Testimonial(june,
      'This guy is an amazing frontend developer that delivered the task exactly how we need it, do your self a favor and hire him, you will not be disappointed by the work delivered. He will go the extra mile to make sure that you are happy with your project. I will surely work again with him!');
  result.add(june_testimonial);

  Client iida = Client('Iida Niskanen',
      'https://randomuser.me/api/portraits/women/68.jpg', 'Data Entry');
  Testimonial iida_testimonial = Testimonial(iida,
      "This guy is a hard worker. Communication was also very good with him and he was very responsive all the time, something not easy to find in many freelancers. We'll definitely repeat with him.");
  result.add(iida_testimonial);

  Client renee = Client('Renee Sims',
      'https://randomuser.me/api/portraits/women/65.jpg', 'Receptionist');
  Testimonial renee_testimonial = Testimonial(renee,
      "This guy does everything he can to get the job done and done right. This is the second time I've hired him, and I'll hire him again in the future.");
  result.add(renee_testimonial);

  Client miyah = Client(
      "Miyah Myles",
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=707b9c33066bf8808c934c8ab394dff6",
      "Marketing");
  Testimonial miyah_testimonial = Testimonial(miyah,
      "I've worked with literally hundreds of HTML/CSS developers and I have to say the top spot goes to this guy. This guy is an amazing developer. He stresses on good, clean code and pays heed to the details. I love developers who respect each and every aspect of a throughly thought out design and do their best to put it in code. He goes over and beyond and transforms ART into PIXELS - without a glitch, every time.");
  result.add(miyah_testimonial);

  return result;
}
