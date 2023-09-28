/*
*/

void main() {
  //
  var p1 = Person('XYZ');
  p1.showDetails();

  var p2 = Person2('ABC', 89);
  p2.showDetails();

  var p3 = Person2.guest();
  p3.showDetails();
}

class Person {
  String? name;
  int? age;

  // [type varname=defaultVal] for optional arguements.
  // Person(String name, [int age = 69]) {
  //   this.name = name;
  //   this.age = age;
  // }

// same as the above.
  Person(this.name, [this.age = 69]);

  void showDetails() => print('A person named ${this.name} aged ${this.age}.');
}

class Person2 {
  String? name;
  int? age;

  // Default Constructor
  Person2(this.name, [this.age = 69]);

  // Name Constructors
  Person2.guest() {
    name = 'Guest';
    age = 6699;
  }

  void showDetails() => print('A person named ${this.name} aged ${this.age}.');
}
