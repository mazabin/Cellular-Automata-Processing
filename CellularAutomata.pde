import g4p_controls.*;

String seedDrawMethod = "evenly";
String simulationType = "conway";
String simulationName = " - Gra w życie Conwaya";
String neighborhood = "moore";
String information = "Wylosuj ziarno i rozpocznij symulację.";
String iterationString = " iteracjach.";
int bc = 1;
int radium = 5;
int neigh = 0;

boolean limitReached = false;
boolean withRadium = false;

Cell[][] cells; 
Cell[][] cellsBuffer; 
int[] seedsArr;

color alive = color(247,202,201);
color dead = color(146,168,209);
float criticalDensity;
float step = 0.001;
float[] rho;

public void setup(){
  size(800, 800, JAVA2D);  
  surface.setResizable(true);
  calculateBoard();
  setColours();
  createGUI();    
  stroke(48);   //grid enable
 // noStroke(); //grid disable
  noSmooth();  
  calculateDensity();
}

void calculateBoard(){
  cells = new Cell[width/cellSize][height/cellSize];
  cellsBuffer = new Cell[width/cellSize][height/cellSize];
  lengthOfArray = (width/cellSize)*(height/cellSize);
  initializeSeeds();
}

void keyPressed() {
  if (key=='r' || key == 'R') {
    initializeSeeds();
  }
  if (key==' ') { // On/off of pause
    pause = !pause;
  }
  if (key=='c' || key == 'C') { // Clear all
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cells[x][y].colour = dead; // Save all to zero
      }
    }
  }
}

public void draw(){
  background(80);
  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      if(cells[x][y].colour!=dead)    
          fill(cells[x][y].colour);
      else       
          fill(dead);
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }  
  
  if(iterationCnt < maxIterations && !limitReached){
    if (millis()-lastRecordedTime>interval) {
      if (!pause) {
        //STARTING SIMULATION //<>//
        iteration();                                  
        iterationCnt++;
        if(iterationCnt!=0)
          information = "Trwa symulacja " + simulationName;        
       
       //STOPPING MONTE CARLO SIMULATION AT FULL BOARD
       if(!simulationType.equals("monte")) {
          int aliveCells = 0;
          for(int i=0; i<width/cellSize; i++){
            for(int j=0; j<height/cellSize; j++){
              if(cells[i][j].colour!=dead)
                aliveCells++;
            }
          }
          if(aliveCells == 0){
            limitReached = true;
            maxIterations = iterationCnt+1;
          }
          if(aliveCells == (width/cellSize)*(height/cellSize) && !simulationType.equals("drx")){
            if(!limitReached){
              maxIterations = iterationCnt+1;
              limitReached = true;
            }
          }       
          lastRecordedTime = millis();
        }
        else {
          boolean unifiedColor = true;
          for(int i=1; i<width/cellSize; i++){
            for(int j=0; j<height/cellSize; j++){
              color base = cells[0][0].colour;
              if(cells[i][j].colour!=base)
                unifiedColor = false;
            }
          }
          if(unifiedColor)
            limitReached = true; //<>//
        }
      }
      else if(iterationCnt == 0 && pause)
        information = "Wybierz symulację i wciśnij start, aby rozpocząć.";
      else if(iterationCnt!=maxIterations && pause)
        information = "Pauza aktywna. Kliknij start, by wznowić symulację.";      
    }
  }  
  else if(limitReached || iterationCnt == maxIterations){
      if(iterationCnt == 1)
        iterationString = " iteracji.";
      information = "Symulacja zakończona po " + iterationCnt + iterationString;
      pause = true;
    }
  tickIteration();
  
}

void mouseClicked(){
  if(pause && mouseEnabled){
    int xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));
    xCellOver = constrain(xCellOver, 0, width/cellSize-1);
    int yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));
    yCellOver = constrain(yCellOver, 0, height/cellSize-1);
    
    if(cellsBuffer[xCellOver][yCellOver].colour == dead) {
      if(simulationType.equals("conway")){
        cells[xCellOver][yCellOver].colour = alive;
        cellsBuffer[xCellOver][yCellOver].colour = alive;
        fill(alive);
      }
      else{
      int rColour = int(random(15));
      cells[xCellOver][yCellOver].colour = cArray[rColour];
      cellsBuffer[xCellOver][yCellOver].colour = cArray[rColour];
      fill(cArray[rColour]);
      }
      seedsNumber++;
    }
    
    else {
      cells[xCellOver][yCellOver].colour = dead; 
      cellsBuffer[xCellOver][yCellOver].colour = dead;
      fill(dead);
      seedsNumber--;
    }
  }
}