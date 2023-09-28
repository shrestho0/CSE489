import 'dart:io';

void main() {
  stdout.writeln("Fuckin line :3. Give something to stdin ");
  String? inputX = stdin.readLineSync(); // ?null safety in ts
  print("The fuckin input: $inputX"); // $varname is called string interpolation
}
