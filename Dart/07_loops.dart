import "dart:io";

void main() {
  print("xxxxxxxxxx xxxxxxxxxx xxxxxxxxxx");
  loops();
  print("xxxxxxxxxx yyyyyyyyyy xxxxxxxxxx");
}

void loops() {
  print("Standard for loop");
  // break; continue; are valid too.

  /// [ NOT SURE ]
  print({}); // everything is interpreted as string in runtime.

  for (var i = 1; i < 5; i++) {
    stdout.write("$i ");
  }
  print('\n');

  print("For-in Loop (regular iterator pattern [NOT SURE])");
  var numbers = [67, 68, 69];
  for (var n in numbers) {
    stdout.write("$n ");
  }
  print('\n');

  print("For-each Loop (regular for each loop like js)");
  numbers.forEach((n) => stdout.write('$n '));
  print('\n');

  print("While Loop (regular while loop)");
  int num = numbers.length - 1;
  while (num > -1) {
    stdout.write('${numbers[num]} ');
    num--;
  }
  print('\n');

  print("Do-While Loop (regular while loop)");
  int i2 = 5;
  do {
    stdout.write('$i2 ');
    i2--;
  } while (i2 > 0);

  print('\n');
}
