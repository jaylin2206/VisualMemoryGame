public class Tile {
  private float x;
  private float y;
  private boolean match = false;
  private boolean clicked = false;
  
  public Tile(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public void setMatch() {
    match = true;
  }
  
  public boolean getMatch() {
    return match;
  }
  
  public void click() {
    clicked = true;
  }
  
  public boolean getClicked() {
    return clicked;
  }
  
  //public boolean collides(float x1, float y1, float x2, float y2) {
  //  if (x1 == x2 && y1 == y2) return true;
  //  return false;
  //}
  
}
