import g4p_controls.*;
void conwayIteration() {
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      getNeighbors(cells[x][y]);
      }
    }
}