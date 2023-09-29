// Getter & Setter are just like js' ones.

class Rectangle {
  int left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  int get right => left + width;
  int get bottom => top + height;

  set right(value) => left = value - width;
  set bottom(value) => top = value - height;

  void printPos() {
    print("x: $left, y: $top; w: $width, h: $height");
  }
}

void main() {
  Rectangle rect = Rectangle(0, 0, 100, 100);
  print("Right: ${rect.right}, Bottom: ${rect.bottom}");
  rect.printPos();

  print('');
  rect.right = 200;
  rect.bottom = 200;
  print("Right: ${rect.right}, Bottom: ${rect.bottom}");
  rect.printPos();
}
