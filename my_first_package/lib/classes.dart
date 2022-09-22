import 'dart:math';

class Numbers {
  static Numbers? _instance;

  final int a;
  final int b;
  final int c;
  final int d;

  factory Numbers({required a, required b, required c, required d}) {
    _instance ??= Numbers._private(a: a, b: b, c: c, d: d); // If null assign

    return _instance!;
  }

  Numbers._private({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });

  // Factory allows to return
  factory Numbers.random(int max) {
    final random = Random();

    // Cannot access this.a

    return Numbers(
        a: random.nextInt(max),
        b: random.nextInt(max),
        c: random.nextInt(max),
        d: random.nextInt(max));
  }
}

class Animal {
  final String name;

  Animal({required this.name});

  void whatAmI() {
    print('I am an animal');
  }

  void chase(Animal animal) {
    print('$name is chasing ${animal.name}');
  }
}

class Cat extends Animal {
  Cat() : super(name: "Tom");

  @override
  void whatAmI() {
    print('I am a cat');
  }

  // "covariant" Tights the type to be of a subclass
  // can be also be used in the super class to allow for all children
  @override
  void chase(covariant Mouse animal) {
    print('The cat $name is chasing the mouse ${animal.name}');
  }
}

class Mouse extends Animal {
  Mouse() : super(name: "Jerry");

  @override
  void whatAmI() {
    print('I am a mouse');
  }
}

// Explicit interface
abstract class ITest {
  late final String name;

  void setUp();
}

class AutoTest implements ITest {
  @override
  String name = "Test";

  @override
  void setUp() {
    print('Preparing test');
  }

  // As all classes are implicit interfaces they can have external "abstract" methods
  external void setUpBots();
}

// Classes can be implemented
class RobotTest implements AutoTest {
  @override
  String name = "Robots test";

  @override
  void setUp() {
    print('Preparing test');
  }

  @override
  void setUpBots() {
    print('Preparing bots');
  }
}

// A multiple hierarchy problem

abstract class CommunicationDevice {
  void call();
}

abstract class SmartPhone extends CommunicationDevice {
  @override
  void call() {
    print('SmartPhone is calling');
  }

  void openYoutube();
}

abstract class Phone extends CommunicationDevice {
  @override
  void call() {
    print('Phone is calling');
  }
}

// Interface enforce the behavior so it just tells IPhone that there should be
// a call method despite SmartPhone and Phone interfaces having 2 call methods
// If we were extending the behavior will be shared so IPhone cannot know witch
// call() needs to call.
class IPhone implements SmartPhone, Phone {
  @override
  void call() {
    print('IPhone is calling');
  }

  @override
  void openYoutube() {
    print('Youtube is opening');
  }
}
