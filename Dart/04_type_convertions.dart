/**
 * Type Convertions
 * * Any type can be converted to any type in Dart
 */
void main() {
  print("Type convertions");

  // String -> Int
  var one = int.parse("1");
  print("One Type ${one.runtimeType}");

  // String -> Double
  var dOne = double.parse('1.1');
  print("dOne Type ${dOne.runtimeType}");

  // String -> Bool
  var boolX = bool.parse('true');
  print("boolX Type: ${boolX.runtimeType}; $boolX ");

  // Int to String;
  String is1 = 69.toString();
  String is2 = 69.69696969.toStringAsFixed(2); // changes somestuff;

  print("numToString-> $is1, $is2");
}
