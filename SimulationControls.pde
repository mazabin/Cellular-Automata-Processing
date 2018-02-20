boolean mouseEnabled = true;
boolean pause = true;

int maxIterations = 1000;
int seedNumberInPercent = 45;
int seedsNumber = 0;
int interval = 70;
int lastRecordedTime = 0;
int iterationCnt = 0;


void startSimulation(){
  if(seedsNumber == 0){ //<>//
    if(seedDrawMethod.equals("mouse"))
      information = "Stwórz ziarna klikając na planszy. Wybierz opcję 'losowe' lub 'równomierne', by automatycznie wylosować zarodki.";
     else
       information = "Liczba ziaren musi być większa niż 0. Nie można rozpocząć symulacji."; //<>//
     simulationInformation.setText(information);
     tickIteration();
  }
  else {
   if(limitReached){
     iterationCnt = 0;
      limitReached = false;
      maxIterations = slider_iteration.getValueI();
      initializeSeeds();
      pause = false;
    }
    if(seedsNumber < (width/cellSize)*(height/cellSize) && seedDrawMethod.equals("monte")){
      information = "Plansza została wypełniona brakującymi ziarnami.";
      simulationInformation.setText(information);
      initializeSeeds();
    }    
    else
      pause = false;
      
    if(iterationCnt == maxIterations){
      maxIterations = maxIterations + slider_iteration.getValueI();
      pause = false;
    }
  }
}
public void pauseSimulation(){
  pause = true;
}

public void stopSimulation(){
  pause = true;
  iterationCnt = 0;
}

void clearBoard(){
   for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cells[x][y].colour = dead;
        cellsBuffer[x][y].colour = dead;
      }
    }
    seedsNumber = 0;
    information = "Kliknij na planszy, by dodać ziarna.";
    simulationInformation.setText(information);
}