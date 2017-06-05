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
  size(800, 600, JAVA2D);  
  surface.setResizable(true);
  cells = new Cell[width/cellSize][height/cellSize];
  cellsBuffer = new Cell[width/cellSize][height/cellSize];
  setColours();
  createGUI();    
  //stroke(48);
  noStroke();
  noSmooth();  
  initializeSeeds();
  calculateDensity();
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
      if(cells[x][y].colour!=dead) {   
          fill(cells[x][y].colour);
      }
      else {                     
          fill(dead);

      }
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }  
  
  if(iterationCnt < maxIterations){
    if (millis()-lastRecordedTime>interval) {
      if (!pause) {
        //STARTING SIMULATION //<>//
        iteration();                                  
        iterationCnt++;
        if(iterationCnt!=0)
          information = "Trwa symulacja: " + simulationName;        
        
        //DEBUG
       // pause = true;
        
       //STOPPING SIMULATION AT FULL BOARD
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
      } //<>//
      else if(iterationCnt == 0 && pause)
        information = "Wybierz symulację i wciśnij start, aby rozpocząć.";
      else if(iterationCnt!=maxIterations && pause)
        information = "Pauza aktywna. Kliknij start, by wznowić symulację.";
      
    }
  }
  
  else{
    if(limitReached){
      if(iterationCnt == 1)
        iterationString = " iteracji.";
      information = "Symulacja zakończona po " + iterationCnt + iterationString;
      pause = true;
    }
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
/**
1. Naiwny rozrost ziaren z sąsiedztwem:
  a. Von Neumanna        --jest
  b. Moore'a             --jest
  c. Hexagonal left
  d. Hexagonal right
  e. Hexagonal random
  f. Pentagonal random
  
2. Warunki brzegowe
  a. periodyczne - zawijanie    vn, moore
  b. nieperiodyczne - odbijające  vn, moore
  
3. Losowanie zarodków
  a. losowe
  b. równomierne - w każdym rzędzie i w każdej kolumnie tyle samo ??
  c. losowe z promieniem R - od losowego ziarna dodajemy jeszcze R w około
  d. przez kliknięcie
  
 
  Do istniejącego GUI dodać:
    Radiobutton group wyboru sąsiedztwa
    Przycisk czyszczący planszę
    Radiobutton group warunków brzegowych
    Radiobutton group losowania zarodków
    Możliwość ustawienia rozmiaru planszy
              Rozmiar planszy - minimum 100x100, maksimum 1600x1200;        -- zmiana rozmiaru okna nie działa
              Rozmiar komórki wybiera użytkownik - miedzy 30 a 5;  5, 10, 15, 20, 25, 30 - 6 opcji    -- zmiana rozmiaru komórki trochę działa
              W zależności od rozmiaru komórki program proponuje rozmiar planszy (kwadrat) i ustawia skok co rozmiar komórki.     
  
  Zmiany w kodzie:
  Wyłaczyć do osobnych funkcji:
    Sprawdzanie sąsiedztw
    Sprawdzanie warunków brzegowych
    losowanie zarodków (b, c)
*/