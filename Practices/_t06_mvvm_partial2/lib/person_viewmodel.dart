import 'package:_t06_mvvm_partial2/person_model.dart';
import 'package:flutter/material.dart';

class PersonViewModel extends ChangeNotifier {
  final List<Person> _personList = [];

  /// maybe a bad choise
  bool _loading = false;

  List<Person> get personList => _personList;
  bool get loading => _loading;

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void addPerson(String name, int age) {
    setLoading(true);
    Person person = Person(name: name, age: age);
    _personList.add(person);
    setLoading(false);
  }

  void removePerson(Person person) {
    setLoading(true);

    _personList.remove(person);
    setLoading(false);
  }

  void updatePerson(Person oldPerson, String? name, int? age) {
    setLoading(true);
    final index = _personList.indexOf(oldPerson);
    if (name != null) {
      _personList[index].name = name;
    }
    if (age != null) {
      _personList[index].age = age;
    }

    setLoading(false);
  }
}
