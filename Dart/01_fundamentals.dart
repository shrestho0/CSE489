import "dart:core"; // this shit is automatically imported in compile time

/**
 * Dart Fundamentals
 * * Static Type
 * * Compiled
 * * =================
 * * Dynamic -> Supports dynamic typing
 */

/**
 * Compilation Types
 * * AOT -> Ahead of time
 * * JIT -> Just in time  
 */

void main() {
  // Function declaration is just type main(){}
  print("The fuckin fundamentals.");

  /**
   * Variables
   * Supports:
   * * Type Inference
   * * Static Defination
   */

  var firstname = "Shrestho"; // type inference
  String lastname = "DCosta"; // defined string type

  const someConst = 6969; // type is infered

  int? nullNum; // null but requires null safety
  String? nullStr; // same as nullNum

  print(firstname + " " + lastname);
  print("Constants $someConst, ${someConst.runtimeType}");
  print("nullNum $nullNum, nullString $nullStr ");
}

/// Documentation of the program, not to use here
void comments() {
  // Single line comment
  /*
  Block Comment
  */
}
