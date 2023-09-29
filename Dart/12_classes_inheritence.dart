void main() {
  var v1 = Vehicle('X', 2016);
  var c1 = Car('Y', 2069, 69.69);

  v1.printDetails();
  c1.printDetails();
}

class Vehicle {
  final model;
  final year;

  Vehicle(this.model, this.year);

  void printDetails() {
    print("Vehicle: $model, $year");
  }
}

class Car extends Vehicle {
  double? price;

  Car(String model, int year, [this.price = 0.0]) : super(model, year);

  @override // just a safety feature, checks if parent has the same feature and improves readability., totally optional but useful.
  void printDetails() {
    print("Vehicle [CAR]: $model, $year, $price");
  }
}
