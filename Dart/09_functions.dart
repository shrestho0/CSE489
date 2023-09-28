// Functions are first-class object in dart

void main() {
  // Support anonymous functions just like js.

  var numList = [1, 2, 3, 4, 5];

  for (var x in numList) {
    print(square(x));
  }

  print('');
  for (var x in numList) print(cube(x));

  print('');
  for (var x in [1.1, 2.2, 3.3, 4.4, 5.5]) print(square(x));
  var x = -1;
  for (x; x < 5; x++) print(sum(n1: x, n2: x + 1));

  print('');

  for (x in numList) print(sumWithPosArgs(2, n1: x, n2: x + 1));

  print('');

  for (x in numList) print(sumWithPosArgs(2, n1: x));

  print('');

  for (x in numList) print(sumWithOptArgs(2, x, 1));
}

dynamic square(var n) {
  return n * n;
}

dynamic cube(var n) => n * n * n;

dynamic sum({var n1, var n2}) => n1 + n2;

dynamic sumWithPosArgs(var multiplier, {var n1, var n2}) =>
    (n1 ?? 0 + n2 ?? 0) * multiplier;

dynamic sumWithOptArgs(var m, [var n1, var n2]) {
  // print('DEBUG  $m, $n1, $n2');
  return (m ?? 1) * (n1 ?? 0 + n2 ?? 0);
}
