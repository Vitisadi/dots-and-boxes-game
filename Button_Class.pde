class Button {
  float x, y, sizex, sizey;
  String label;

  Button(String l, float _x, float _y) {
    label = l;
    x = _x;
    y = _y;
    sizex = 200;
    sizey = 45;
  }

  void display() {
    strokeWeight(5);
    rectMode(CENTER);
    fill(255);
    rect(x, y, sizex, sizey);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(30);
    text(label, x, y);
    strokeWeight(1);
    rectMode(CORNER);
  }

  boolean clicked() {
    if (mouseX > x-sizex/2 && mouseX < x+sizex/2 && mouseY > y-sizey/2 && mouseY < y+sizey/2) return true;
    return false;
  }
}
