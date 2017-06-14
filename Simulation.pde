void iteration(){
  if(simulationType.equals("conway"))
    conwayIteration();
  else if(simulationType.equals("naive"))
    naiveIteration();
  else if(simulationType.equals("monte"))
    monteIteration();
  else if(simulationType.equals("drx"))
    recrystalizationIteration();
  else if(simulationType.equals("wolfram"))
    wolframIteration();

  copyBuffer();
}

void copyBuffer(){
  for(int x=0; x<width/cellSize; x++){    
    for(int y=0; y<height/cellSize; y++){
      cells[x][y].x = cellsBuffer[x][y].x;
      cells[x][y].y = cellsBuffer[x][y].y;
      cells[x][y].colour = cellsBuffer[x][y].colour;
      cells[x][y].dislocationDensity = cellsBuffer[x][y].dislocationDensity;
      cells[x][y].wasChecked = cellsBuffer[x][y].wasChecked;
      cells[x][y].numberOfChecks = cellsBuffer[x][y].numberOfChecks;
    }
  }
}

void wolframIteration(){
  println("Wolfram not implemented");
}

void initializeSeeds(){
  for(int i=0; i<width/cellSize; i++){
    for(int j=0; j<height/cellSize; j++){
      cells[i][j] = new Cell();
      cellsBuffer[i][j] = new Cell();
      cells[i][j].x = i;
      cellsBuffer[i][j].x = i;
      cells[i][j].y = j;
      cellsBuffer[i][j].y = j;
      cells[i][j].colour = dead;
      cellsBuffer[i][j].colour = dead;
    }
  }
  
  if(simulationType.equals("monte")){
      for(int x=0; x<width/cellSize; x++){
        for(int y=0; y<height/cellSize; y++){
           cells[x][y].colour = cArray[int(random(15))];
           cellsBuffer[x][y].colour = cells[x][y].colour;
        }
      }
      seedsNumber = (width/cellSize)*(height/cellSize);
    }

  else if(simulationType.equals("wolfram")){
    cells[width/cellSize/2][0].colour = alive;
  }
  
  else
  {
    if(simulationType.equals("drx")){
      int a=0;
      int b=0;
          for(int i=0; i<5; i++){      
          a = int(random(width/cellSize/5)) + a;
          b=0;
          for(int j=0; j<3; j++){
            b = int(random(height/cellSize/3)) + b;
            cells[a][b].colour = cArray[int(random(15))];
          }          
        }
      }
      
     else
     {   
      seedsArr = new int[(width/cellSize*seedNumberInPercent)/100];
      switch(seedDrawMethod){
        case "evenly":            //Same amount of seeds in every row
        {
          for(int j=0; j<height/cellSize; j++){
            for(int i=0; i<seedsArr.length; i++){
               seedsArr[i] = int(random(width/cellSize));
               int rcolour = int(random(15));
               cells[seedsArr[i]][j].colour = cArray[rcolour];
               cellsBuffer[seedsArr[i]][j].colour = cArray[rcolour];
               if(simulationType.equals("conway")){
                  cells[seedsArr[i]][j].colour = alive;
                  cellsBuffer[seedsArr[i]][j].colour = alive;
                }
             }
          } 
        }
        break;
        case "random":        //random seeds location
        {
          int x;
          int y;
          int seedsNumber;
          if(!withRadium){
            seedsNumber = ((height/cellSize)*(width/cellSize)*seedNumberInPercent)/100;
            while(seedsNumber!=0){
              x = int(random(width/cellSize));
              y = int(random(height/cellSize));
              if(cells[x][y].colour == dead){
                cells[x][y].colour = cArray[int(random(15))];
                cellsBuffer[x][y].colour = cells[x][y].colour;
                if(simulationType.equals("conway")){
                    cells[x][y].colour = alive;
                    cellsBuffer[x][y].colour = alive;
                }
                seedsNumber--;              
              }
            }
          }
          else if(withRadium){
            seedsNumber = ((height/cellSize)*(width/cellSize)*seedNumberInPercent)/100/radium;
            while(seedsNumber!=0){
              x = int(random(width/cellSize));
              y = int(random(height/cellSize));
              if(cells[x][y].colour == dead){
                  color col = cArray[int(random(15))];
                  if(simulationType.equals("conway"))
                    col = alive;
                  cells[x][y].colour = col;
                  cellsBuffer[x][y].colour = col;
                  for(int i=0; i<radium; i++){
                    for(int j=0; j<radium; j++){
                      int a = x+i;
                      int b = y+j;
                      int c = x-i;
                      int d = y+j;
                      
                      if(bc == 1){                        
                        if(x+i > width/cellSize)
                          a = 0 + i - ((width/cellSize)-1 - x);      //x=498 R=3 w = 500; 500-498 = 0 + i-(width-x)
                        if(x-i < 0)
                          c = (width/cellSize)-1 - (i-x);              //x=2, R=3, w=100 -> ostatni 99  width - 1 - r-x
                        if(y+j > height/cellSize)
                          b = 0 + j - ((height/cellSize)-1 - y);
                        if(y-j < 0)
                          d = (height/cellSize)-1 - (j-y);   
                      }
                      else {
                      if(x+i > width/cellSize)
                          a = (width/cellSize)-1;
                        if(x-i < 0)
                          c = 0;
                        if(y+j > height/cellSize)
                          b = (height/cellSize)-1;
                        if(y-j < 0)
                          d = (height/cellSize)-1 - (j-y); 
                      }
                        if(cells[a][b].colour == dead) 
                          cells[a][b].colour = cells[x][y].colour;
                        if(cells[c][d].colour == dead)
                          cells[c][d].colour = cells[x][y].colour;
                        if(cells[a][d].colour == dead)
                          cells[a][d].colour = cells[x][y].colour;
                        if(cells[c][b].colour == dead)
                          cells[c][b].colour = cells[x][y].colour;
                      }
                    } 
                  }
                seedsNumber--; 
              }
            }
          }
        break;
        case "mouse":
        {
          clearBoard();
          println("Click on board to add new seeds");
        }
        break;
      }
    }
  }
}