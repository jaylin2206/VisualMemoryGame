color[] colors = new color[]{#7571c8, #BAB3E2, #F2F1F8, #4B4471};
int bg = 0;
int tile = 1;
int match = 2;
int miss = 3;

int level = 1;
int highestLevel = 1;

Grid a = new Grid();
boolean started = false;
boolean gameOver = false;
boolean firstTry = true;
int lives = 3;
int misses = 0;
int matches = 0;

PFont large;
PFont kindOfLarge;
PFont medium;
PFont small;
PFont smaller;

//boolean test = true;

void setup() {  
  size(2048, 1200);
  background(colors[bg]);
  
  large = createFont("Courier New Bold", 200, true);
  kindOfLarge = createFont("Courier New Bold", 164, true);
  medium = createFont("Courier New Bold", 128, true);
  small = createFont("Courier New Bold", 64, true);
  smaller = createFont("Courier New Bold", 24, true);
}

void draw() {
  if (firstTry) {
    //if (test) {
    //  for (String s: PFont.list()) System.out.println(s);
    //}
    //test = false;
    textFont(kindOfLarge);
    textAlign(CENTER, TOP);
    text("Visual Memory Game", 1024, 66);
    textFont(small);
    text("Click anywhere to start.", 1024, 900);
  }
  else if (gameOver) {
    background(colors[bg]);
    fill(colors[match]);
    textFont(large);
    textAlign(CENTER, TOP);
    text("GAME OVER", 1024, 66);
    textFont(medium);
    text("Level " + level, 1024, 322);
    textFont(small);
    if (level > highestLevel) text("(new record!)", 1024, 578);
    textAlign(CENTER, BOTTOM);
    text("Click anywhere to restart.", 1024, 1156);
  }
  else {
    printGrid();
    textFont(smaller);
    fill(colors[match]);
    
    textAlign(RIGHT, TOP);
    text("By Jay Lin", 412, 66);
    text("github.com/jaylin2206", 412, 110);
    text("Inspired by Human Benchmark", 412, 154);
    
    textAlign(LEFT, TOP);
    text("Lives: " + lives, 1636, 66);
    text("Current Level: " + level, 1636, 110);
    text("Highest Level: " + highestLevel, 1636, 154);
  }
}

void reset() {
  a = new Grid();
  started = false;    
  lives = 3;
  misses = 0;
  matches = 0;
  background(colors[bg]);
}

void mouseClicked() {
  if (gameOver) {
    if (level > highestLevel) highestLevel = level;
    level = 1;
    gameOver = false;
  }
  else if (!firstTry) {
    for (Tile[] tt: a.getCoords()) {
      for (Tile t: tt) {
        if (t.getX() <= mouseX && mouseX <= t.getX() + a.getTileSize()) {
          if (t.getY() <= mouseY && mouseY <= t.getY() + a.getTileSize()) {
              started = true;
            if (t.getClicked() == false) {
              t.click();
              if (t.getMatch() == false) {
                misses++;
                if (misses == 3) {
                  lives--;
                  a.createGrid();
                  misses = 0;
                  matches = 0;
                  started = false;
                  background(colors[bg]);
                }
                if (lives == 0) {
                  gameOver = true;
                  reset();
                }
              }
              else {
                matches++;
                if (matches == level + 2) updateLevel();
              }
            }
          }
        }
      }
    }
  }
  firstTry = false;
}

void updateLevel() {
  misses = 0;
  matches = 0;
  level++;
  a.updateGrid();
  started = false;
  background(colors[bg]);
}

void printGrid() {
  background(colors[bg]);
  fill(colors[tile]);
  for (Tile[] tt: a.getCoords()) {
    for (Tile t: tt) {
      if (t.getMatch() && started != true) fill(colors[match]);
      if (t.getMatch() && t.getClicked()) fill(colors[match]);
      if (t.getMatch() != true && t.getClicked()) fill(colors[miss]);
      square(t.getX(), t.getY(), a.getTileSize());
      fill(colors[tile]);
    }
  }
}
