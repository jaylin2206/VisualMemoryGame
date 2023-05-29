public class Grid {
  private int offsetX = 512;
  private int offsetY = 66;
  Tile[][] coords;
  private int size = 3;
  private float tileSize;
  private float tileSpacing = 20;
  
  private int level = 1;
  
  public Grid() {
    createGrid();
  }
  
  public void updateGrid() {
    level++;
    if ((level + 2) * 2 > (size * size)) updateSize();
    createGrid();
  }
  
  public void updateSize() {
    size++;
    tileSpacing -= 2;
  }
  
  public void createGrid() {
    tileSize = (1024 - (tileSpacing * (size - 1)) ) / size;
    coords = new Tile[size][size];
    populateGrid();
    setMatches();
  }
  
  public void populateGrid() {
    float tileSpacingOffsetX = 0;
    float tileSpacingOffsetY = 0;
    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        coords[y][x] = new Tile(offsetX + tileSpacingOffsetX + x * tileSize, offsetY + tileSpacingOffsetY + y * tileSize);
        tileSpacingOffsetX += tileSpacing;
      }
      tileSpacingOffsetY += tileSpacing;
      tileSpacingOffsetX = 0;
    }
  }
  
  public void setMatches() {
    for (int i = 0; i < level + 2; i++) {
      int x = (int) (Math.random() * size);
      int y = (int) (Math.random() * size);
      while (coords[y][x].getMatch()) {
        x = (int) (Math.random() * size);
        y = (int) (Math.random() * size);
      }
      //System.out.println(x + "  " + y);
      coords[y][x].setMatch();
    }
  }
  
  public float getTileSize() {
    return tileSize;
  }
  
  public Tile[][] getCoords() {
    return coords;
  }
}
