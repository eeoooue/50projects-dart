import 'dart:html';

void main() {
  List<Element> nums = document.querySelectorAll('.nums span');

  runAnimation(nums);

  var replayBtn = document.querySelector('#replay');
  replayBtn?.addEventListener("click", (event) {
    resetState(nums);
    runAnimation(nums);
  });
}

void resetState(List<Element> nums) {
  var counter = document.querySelector('.counter');
  var finalMessage = document.querySelector('.final');
  counter?.classes.remove("hide");
  finalMessage?.classes.remove("show");

  for (Element num in nums) {
    num.classes.clear();
  }

  nums[0].classes.add("in");
}

void runAnimation(List<Element> nums) {
  for (int i = 0; i < nums.length; i++) {
    Element num = nums[i];

    num.addEventListener('animationend', (e) {
      if (e is AnimationEvent) {
        processAnimEnd(e, num, nums, i);
      }
    });
  }
}

void processAnimEnd(AnimationEvent e, Element num, List<Element> nums, int i) {
  var nextToLast = nums.length - 1;
  var counter = document.querySelector('.counter');
  var finalMessage = document.querySelector('.final');

  if (e.animationName == 'goIn' && i != nextToLast) {
    num.classes.remove('in');
    num.classes.add('out');
  } else if (e.animationName == 'goOut' && num.nextElementSibling != null) {
    num.nextElementSibling?.classes.add('in');
  } else {
    counter?.classes.add('hide');
    finalMessage?.classes.add('show');
  }
}
