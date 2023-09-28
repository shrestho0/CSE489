import 'dart:io';

void main() {
  // List [ just list ]
  someList();
  // Set [ unique ]
  someSet();
  // Map
  someMap();
}

void someList() {
  print("========== Some List ==========");
  List names = ['A', 'B', 'C'];
  var names2 = ['A2', 'A2', 'A3'];

  var namesRef = names; // referencing..
  var namesCopy = [...names]; // spreading / deep copy
  print('$names, $names2');

  for (var name in names) stdout.write('$name, ');
  print('\n');
  names[0] = 'X';
  for (var name in namesRef) stdout.write('$name, ');
  print('\n');
  for (var name in namesCopy) stdout.write('$name, ');
  print('\n');
}

void someSet() {
  print("========== Some Set ==========");

  var interalLinkedHashmap =
      {}; // by default this is map, as nothing is defined.
  var compactLinkedHashSet = <String>{}; // this is set

  print("${interalLinkedHashmap.runtimeType};");
  print("${compactLinkedHashSet.runtimeType};");

  Set setA = {'A', 'B', 'C', 'A'}; // unnesessary but important for learning..
  for (var el in setA) stdout.write('$el, ');
  print('\n');
}

void someMap() {
  print("========== Some Map ==========");

  // keys can be any primitives.
  var kv = {'A': 1, 'B': 2, 'C': 3, false: 'x', 1: 'xxx', null: 'nullxxx'};

  print(kv);
  print(kv[false]);
  print(kv[null]);
}
