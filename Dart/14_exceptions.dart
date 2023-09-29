void main() {
  doSomeThingWithValue(69);
  doSomeThingWithValue(-1);
  doSomeThingWithValue(-2);
}

// Exception handling are similar to js' ones.

class LessThanZeroException implements Exception {
  final String message;
  LessThanZeroException([this.message = "This value can not be less than 0"]);

  @override
  String toString() => "LessThanZeroException: ${this.message}";
}

class LessThanNegetiveOneException implements Exception {
  final String message;
  LessThanNegetiveOneException(
      [this.message = "This value can not be less than -1"]);
  @override
  String toString() => "LessThanNegetiveOne: ${this.message}";
}

int mustBeGreaterThanZero(int value) {
  if (value < -1) {
    throw LessThanNegetiveOneException();
  } else if (value < 0) {
    throw LessThanZeroException();
  }
  return value;
}

void doSomeThingWithValue(int value) {
  var verifiedValue;

  try {
    verifiedValue = mustBeGreaterThanZero(value);
  } on LessThanZeroException {
    print("Found value less than 0; fixing and  making it 0.");
    verifiedValue = 0;
  } on Exception catch (e) {
    print("$e");
  } catch (e) {
    print("Some really unknown error");
  } finally {
    if (verifiedValue == null) {
      print("Could not verify the value `$verifiedValue`");
    } else {
      print("Verified! verifiedValue: $verifiedValue");
    }
  }
}
