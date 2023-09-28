/**
 * unary postfix 	expr++    expr--    ()    []    ?[]    .    ?.    ! 	None
unary prefix 	-expr    !expr    ~expr    ++expr    --expr      await expr    	None
multiplicative 	*    /    %  ~/ 	Left
additive 	+    - 	Left
shift 	<<    >>    >>> 	Left
bitwise AND 	& 	Left
bitwise XOR 	^ 	Left
bitwise OR 	| 	Left
relational and type test 	>=    >    <=    <    as    is    is! 	None
equality 	==    !=    	None
logical AND 	&& 	Left
logical OR 	|| 	Left
if null 	?? 	Left
conditional 	expr1 ? expr2 : expr3 	Right
cascade 	..    ?.. 	Left
assignment 	=    *=    /=   +=   -=   &=   ^=   etc. 	Right
 */

class Num {
  int? num = 69;
}

void main() {
  // Null Aware Operator
  // var n = Num();
  // int nToUse;

  // if (n != null) {
  //   nToUse = n.num;
  // } else {
  //   nToUse = -1;
  // }

  // print("nToUse-> $nToUse");

  var n = Num();
  int nToUse;

  // null checker && null safety
  nToUse = n?.num ?? 0; //
  print("n-> $n");
  print("nToUse-> $nToUse");

  // assign default value

  int? num2;
  print(num2 ??= 69);
  print(num2);

  // ternary

  var x = 69.8;
  var res = x % 2 == 0 ? 'even' : 'odd';
  print("res-> $res");

  // type checker

  if (x is int) {
    print('x-> $x -> is integer');
  } else {
    print('x-> $x -> not integer');
  }

  //
}
