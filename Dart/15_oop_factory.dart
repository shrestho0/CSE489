import 'dart:convert';

/// Factories 003
class PersonModel {
  final String firstName;
  final String lastName;
  final int age;
  // final AddressModel address;

  PersonModel(this.firstName, this.lastName, this.age);

  factory PersonModel.fromJson(Map json) {
    return PersonModel(json['firstName'], json['lastName'], json['age']);
  }

  factory PersonModel.fromJsonString(String jsonString) {
    return PersonModel.fromJson(jsonDecode(jsonString));
  }

  String toJsonString() {
    return jsonEncode({
      "firstName": this.firstName,
      "lastName": this.lastName,
      "age": this.age,
    });
  }
}

void main() {
  PersonModel p01 = PersonModel("X", "Y", 69);
  print(p01.toJsonString());
  PersonModel p02 = PersonModel.fromJsonString(p01.toJsonString());
  print(p02.toJsonString());

  print({p01.hashCode, p02.hashCode});
}










/// Factories 002

// class Area {
//   final int height;
//   final int width;
//   final int area;
//   // late int area;

//   const Area._internal(this.height, this.width) : area = height * width;
//   // Area._internal(this.height, this.width) {
//   //   this.area = this.width * this.height;
//   // }

//   factory Area.factory(int height, int width) {
//     if (height < 0 || width < 0) {
//       throw Exception("Height/Width can not be negetive");
//     }
//     return Area._internal(height, width);
//   }
//   void printArea() {
//     print("[Area object] height:$height, width: $width, $area");
//   }
// }

// void main() {
//   Area area01 = Area.factory(10, 20);
//   Area area02 = Area.factory(10, 20);
//   area01.printArea();
//   area02.printArea();
// }









/// Factories 001

// class Logger {
//   final String name;
//   bool mute = false;

//   // private/internal constructor we want to hide, though it's not hidden
//   Logger._internal(this.name);

//   static final Map<String, Logger> _cache = <String, Logger>{};

//   /// Logger Factory [that creates instances and keeps in cache]
//   factory Logger(String name) {
//     if (_cache.containsKey(name)) {
//       print("[Already] in cache :: $_cache");
//     } else {
//       print("[Absent] in cache :: $_cache");
//     }

//     return _cache.putIfAbsent(name, () => Logger._internal(name));
//   }

//   /// Calls the Logger factory
//   factory Logger.fromJson(Map<String, Object> json) {
//     return Logger(json['name'].toString());
//   }

//   void log(String msg) {
//     if (!mute) {
//       print(msg);
//     }
//   }
// }

// void main() {
//   Logger l01 = Logger('x');
//   print("l01, ${l01.name}");

//   Logger l02 = Logger('y');
//   print("l02, ${l02.name}");

//   Logger l03 = Logger.fromJson({"name": "x"});
//   print("l03, ${l03.name}");

//   Logger l04 = Logger._internal('y');
//   print("l04, ${l04.name}");
// }


/// Super parameters

// class Vector2D {
//   final double x;
//   final double y;
//   Vector2D(this.x, this.y);
// }

// class Vector3D extends Vector2D {
//   final double z;
//   Vector3D(super.x, super.y, this.z);
// }

// void main() {
//   var v1 = Vector2D(10, 20);
//   var v2 = Vector3D(4, 5, 6);
//   print(v1);
//   print(v2);
// }

/// Invoking a non-default superclass constructor

// class Person {
//   String? name;
//   DateTime? birthday;

//   Person.fromJson(Map data) {
//     this.name = data['name'];
//     this.birthday = data['birthday'];
//     print("Data from Person $data");
//   }
// }

// class Employee extends Person {
//   Employee.fromJson(data) : super.fromJson(data) {
//     print("Data from Employee $data");
//   }
// }

// void main() {
//   var empOne = Employee.fromJson({
//     "name": "xy",
//     "birthday": DateTime(1990, 10, 10),
//   });
//   var two = Employee.fromJson({
//     "name": "mn",
//     "birthday": DateTime(2020, 10, 10),
//   });

//   print("EmpOne from main() $empOne");
// }
