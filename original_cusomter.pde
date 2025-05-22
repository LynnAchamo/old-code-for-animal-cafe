// --- Customer class ---
class Customer {
  String name;
  float x, y;
  float targetX;
  String state;
  int stateTimer;

  Customer(String name, float x, float y) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.targetX = 100;
    this.state = "waiting";
    this.stateTimer = 0;
  }

  void stateTransitions(int orderingIndex, int eatingIndex) {
    stateTimer++;

    if (state.equals("waiting") && orderingIndex == -1) {
      state = "ordering";
      stateTimer = 0;
    } else if (state.equals("ordering") && stateTimer > 120 && eatingIndex == -1) {
      state = "eating";
      stateTimer = 0;
    } else if (state.equals("eating") && stateTimer > 180) {
      state = "exiting";
    }
  }

  void updateTargetX(float tx) {
    targetX = tx;
  }

  void stepAndDraw() {
    if (!state.equals("exiting")) {
      x += (targetX - x) * 0.1;
    } else {
      x += 2;
    }

    // Draw
    fill(0);
    textAlign(CENTER);
    ellipse(x, y, 40, 40);
    fill(255);
    text(name.charAt(0), x, y + 5);

    fill(0);
    textAlign(LEFT);
    text(state, x + 25, y);
  }
}
