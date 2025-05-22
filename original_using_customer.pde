
ArrayList<Customer> customers;
String[] names = {"Alice", "Bob", "Coco", "Daisy", "Eddie"};
int spawnTimer = 0;

void setup() {
  size(800, 400);
  customers = new ArrayList<Customer>();
}

void draw() {
  background(255);

  boolean someoneIsWaiting = customers.stream().anyMatch(c -> c.state.equals("waiting"));

  spawnTimer++;
  if (spawnTimer > 120 && !someoneIsWaiting) {
    customers.add(new Customer(randomName(), 0, height / 2));
    spawnTimer = 0;
  }

  int orderingIndex = -1;
  int eatingIndex = -1;
  int waitingCount = 0;

  for (int i = 0; i < customers.size(); i++) {
    Customer c = customers.get(i);
    if (c.state.equals("ordering") && orderingIndex == -1) orderingIndex = i;
    if (c.state.equals("eating") && eatingIndex == -1) eatingIndex = i;
  }

  for (Customer c : customers) {
    c.stateTransitions(orderingIndex, eatingIndex);
  }

  for (Customer c : customers) {
    if (c.state.equals("waiting")) {
      c.updateTargetX(100 + waitingCount * 45);
      waitingCount++;
    } else if (c.state.equals("ordering")) {
      c.updateTargetX(400);
    } else if (c.state.equals("eating")) {
      c.updateTargetX(500);
    }
  }

  for (Customer c : customers) {
    c.stepAndDraw();
  }

  customers.removeIf(c -> c.state.equals("exiting") && c.x > width);
}

String randomName() {
  return names[(int)random(names.length)];
}
