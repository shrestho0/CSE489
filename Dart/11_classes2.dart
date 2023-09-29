void main() {
  SomePersonClass p01 = SomePersonClass("X", 69);
  p01.printDetails();

  p01.age = 66;
  // p01.name = 'ss'; // NOT VALID as used final.
  p01.printDetails();
  print(SomePersonClass.ptype); // only accesable with classname.
}

class SomePersonClass {
  final name; // null in compile time, populated once in runtime and then becomes const, acts like const outside of class.
  int age; // regular mutable variable that can be mutated from outside.

  static const ptype = "Human"; // an class variable.

  SomePersonClass(this.name, this.age);

  void printDetails() {
    print("SomePerson Named: ${this.name} aged ${this.age} is an ${ptype}");
  }
}
