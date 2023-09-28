void main() {
  print("xxxxxxxxxx xxxxxxxxxx xxxxxxxxxx");
  someConditionalsStuff();
  someSwitchCaseStuff();
  print("xxxxxxxxxx xxxxxxxxxx xxxxxxxxxx");
}

void someConditionalsStuff() {
  print("########## Conditionals ##########");
  print(bool.parse('false') ? 'x' : 'y');
  print("########## Conditionals Ends ##########");
}

void someSwitchCaseStuff() {
  print("########## Switch Case Statement ##########");

  var number = 68;
  switch (number) {
    case 0:
    case 1:
    case 69 || 68 || 67:
      print("Fallthrough till $num and previous would be !considered");
      break;
    case 70:
      print('doesnt matter, never going to be here');
      break; // just some good practice
    default:
      print(
          'fuckin default value, will be executed if not `break` in previous blocks');
  }

  print("########## Switch Case Statement Ends ##########");
}
