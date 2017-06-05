void naiveIteration(){
for(int x=0; x<width/cellSize; x++){  
  for(int y=0; y<height/cellSize; y++){
    if(cells[x][y].colour!=dead){
      getNeighbors(cells[x][y]);
      }
    }
  }
}