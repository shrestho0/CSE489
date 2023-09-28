void main() {
  /*

  // Primitives Known in compile-time
  int
  double
  String
  bool

  // Primitive but can be changed in run-time
  dynamic 
  */
  // Every shit is an object here.

/**
 * Static Types
 * * Type can not be changed in run time.
 */

  int num1 = 34;
  var num2 = 35;

  print("Num1, num2 ${num1 + num2}");

  double dnum1 = 33.5;
  var dnum2 = 35.5;

  print("Dnum1, Dnum2 ${dnum1 + dnum2}");

  String someString = "Some Fuckin String";
  var anotherString = "Some another fucking String";

  print("someString, anotherString, ${someString + ' ' + anotherString}");

  bool isFucking = true;
  var notFucking = false;

  print("isFucking: $isFucking, notFucking: $notFucking ");

/*
* Dynamic Type
* * This is like weakVariable
*/

  dynamic xxx = 69;
  print("xxx-> $xxx");
  xxx = "anotherXXX";
  print("xxx-> $xxx");

  print("========== Strings ==========");
  printStrings();
  print("========== Strings Ends ==========");

  print("========== Interop ==========");
  varInterop();
  print("========== Interop ==========");
}

void printStrings() {
  // Strings are just like pythons ones';
  var s1 = "s1";
  var s2 = 's2';
  var s3 = '\'';
  var s4 = "\"";

  String rawString =
      r"some raw string \n that does not evaluate '\n' in the stdout";

  print("$s1, $s2, $s3, $s4");
  print("raw string: $rawString");

//  multiline

  var ms1 = """
Some Multiline String
  """;

  print(ms1);
}

void varInterop() {
  var age = 69;
  var name = "X";

  var xdata = 'interop: $name $age';
  var xdatax = "$name 's age is $age";

  print("Interop, $xdata");
  print("Interop, $xdatax");
}
