int targetCellX;
int targetCellY;
int[][] toShuffle;  
int lengthOfArray; //<>//

void monteIteration(){
  createCoordinatesArray();
  //checkedCells = (width/cellSize)*(height/cellSize);
  //while(checkedCells>0)
  //{
    Cell cell;
    for(int i=0; i<lengthOfArray; i++){
      cell = cells[toShuffle[i][0]][toShuffle[i][1]]; //<>//
      if((!cells[cell.x][cell.y].wasChecked) || (cells[targetCellX][targetCellY].wasChecked &&  cells[targetCellX][targetCellY].numberOfChecks < 5)){        
        checkEnergy(cell);
    }
  }
  }
      //targetCellX = int(random(width/cellSize));
      ////targetCellY = int(random(height/cellSize));
      //for(int i=0; i<width/cellSize; i++){
      //  for(int j=0; j<height/cellSize; j++){
           //Sprawdzamy energię komórki jeśli
           //NIE była sprawdzona
           //BYŁA sprawdzona, ale mniej niż 5 razy
          //if(!cells[targetCellX][targetCellY].wasChecked) { // || (cells[targetCellX][targetCellY].wasChecked &&  cells[targetCellX][targetCellY].numberOfChecks < 5)) {  
          //  println("Sprawdzam komórkę (" + targetCellX + ", " + targetCellY + ")");
          //  checkEnergy(cells[targetCellX][targetCellY]);
          //}
        //}
//      }
//    }
 
void checkEnergy(Cell c){
  color currentCellColour = c.colour;
  int newEnergy;
  getNeighbors(c);
  c.energy = getCellEnergy(c);
  if(c.energy !=0){
    currentCellColour = c.colour;
    c.colour = cArray[int(random(15))];
    newEnergy = getCellEnergy(c);
    if(newEnergy > c.energy)
      c.colour = currentCellColour;
  }  
  c.wasChecked = true;
  c.numberOfChecks++;
  cellsBuffer[c.x][c.y].colour = c.colour;
  cellsBuffer[c.x][c.y].energy = c.energy;
  cellsBuffer[c.x][c.y].wasChecked = false;
  cellsBuffer[c.x][c.y].numberOfChecks = 0;
}

int getCellEnergy(Cell c){
  int energy = 0;
  for(int i=0; i<c.n; i++){
    if(cells[c.neighbors[i][0]][c.neighbors[i][1]].colour != c.colour)
      energy++;
  }
  return energy;
}

void createCoordinatesArray(){
  toShuffle = new int[lengthOfArray][2];
  int x=0;  //max 800
  int y=0;  //max 600
  for(int i=0; i<lengthOfArray; i++){
    toShuffle[i][0] = cells[x][y].x;
    toShuffle[i][1] = cells[x][y].y;
    y++;
    if(y==120){
      y=0;
      x++;
    }
  }  
  
  int r1;
  int r2;
  for(int i=0; i<lengthOfArray/2; i++){
    r1 = int(random(lengthOfArray));
    r2 = int(random(lengthOfArray));
    if(r1!=r2)
      {
        int tmpX = toShuffle[r1][0];
        int tmpY = toShuffle[r1][1];
        toShuffle[r1][0] = toShuffle[r2][0];
        toShuffle[r1][1] = toShuffle[r2][1];
        toShuffle[r2][0] = tmpX;
        toShuffle[r2][1] = tmpY;
      }
    }
  }


/*
Zaczynamy od szumu
~~50 różnych kolorów
Losowo odpytujemy komórki - tak by były sprawdzone pzrynajmniej raz
Sprawdzamy energię otoczenia - sąsiadów  
*/