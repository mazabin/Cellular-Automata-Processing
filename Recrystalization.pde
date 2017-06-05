boolean growth = false;
boolean isOnEdge;
boolean neighbourRecrystalized;
boolean isLower;
boolean dislocate = false;
boolean recrystalize = false;
float dislocationWeigh = 0.0;
float rest = 0.0;


void recrystalizationIteration(){
  if(!growth){
    int maxAliveCells = 1;
    while(maxAliveCells != 0){
      maxAliveCells = (width/cellSize)*(height/cellSize);
      for(int i=0; i<width/cellSize; i++){
        for(int j=0; j<height/cellSize; j++){
          if(cells[i][j].colour!=dead)
            maxAliveCells--;
        }
      }
      if(maxAliveCells!=0)
        naiveIteration();
      copyBuffer();
    }
    growth = true;
  }
    else {
      for(int x=0; x<width/cellSize; x++){
        for(int y=0; y<height/cellSize; y++){
          isOnEdge = false;          
          neighbourRecrystalized = false;
          dislocate = false;
          recrystalize = false;
          dislocationWeigh = 0.0;
          
          if(cells[x][y].dislocationDensity > criticalDensity && !cells[x][y].wasCrystalized)
            recrystalize(cells[x][y]);
          else {
            getNeighbors(cells[x][y]);  
            for(int j=0; j<cells[x][y].n; j++){
              dislocate = true;
              if(cells[x][y].neighbors[j][2] != cells[x][y].colour){
                dislocationWeigh = 0.8;
                
                //GRANICA ZIARNA
                isOnEdge = true; 
                int n = cells[x][y].neighbors[j][0];
                int m = cells[x][y].neighbors[j][1];
                if(cells[n][m].wasCrystalized){
                  neighbourRecrystalized = true;
                  float [] neighborsDensity = new float[cells[x][y].n];
                  isLower = false;
                  for(int k=0; k<cells[x][y].n; k++){
                    int a = cells[x][y].neighbors[k][0];
                    int b = cells[x][y].neighbors[k][1];
                    neighborsDensity[k] = cells[a][b].dislocationDensity;
                    if(neighborsDensity[k] < cells[x][y].dislocationDensity){
                       isLower = true;
                       recrystalize = true;
                       dislocate = false;                       
                    }
                  }
                  if(!isLower){
                    dislocate = true;
                    recrystalize = false;
                  }
                }
              }
            }
            if(dislocate && dislocationWeigh == 0.0)
              dislocationWeigh = 0.2;
          }
          if(dislocate)
            addDislocationDensity(cells[x][y], dislocationWeigh);
          else if(recrystalize)
            recrystalize(cells[x][y]);
        }         
      }
      addRest();
    }
    for(int x=0; x<width/cellSize; x++){
      for(int y=0; y<height/cellSize; y++){
          Moore(cells[x][y]);
      }
    }
}

void addDislocationDensity(Cell c, float weigh){
  if(iterationCnt!=0)
    cellsBuffer[c.x][c.y].dislocationDensity += ((rho[iterationCnt] - rho[iterationCnt-1]) * weigh)/((width/cellSize)*(height/cellSize));
    rest += ((rho[iterationCnt] - rho[iterationCnt-1]) * (1-weigh))/((width/cellSize)*(height/cellSize)); 
}

void recrystalize(Cell c){
  cellsBuffer[c.x][c.y].colour = crystalColor;
  cellsBuffer[c.x][c.y].wasCrystalized = true;
  cells[c.x][c.y].wasCrystalized = true;
  cellsBuffer[c.x][c.y].dislocationDensity = 1;
}

void calculateDensity(){
  float A = 86710969050178.5;
  float B = 9.41268203527779;
  float t = step;
  
  rho = new float[maxIterations];
  rho[0] = 1;
  for(int i=1; i<maxIterations; i++){
    rho[i] = A/B+(1-(A/B))*exp(-1*B*t);
    t += step;
  }
  criticalDensity = 6.21584E+8;
}

void addRest(){
  Cell[] edges = new Cell[1];
  Cell c;
  int edgesCnt = 0;
  for(int x=0; x<width/cellSize; x++){
    for(int y=0; y<height/cellSize; y++){
      c = cells[x][y];
      for(int i=0; i<cells[x][y].n; i++){
        if(cells[c.neighbors[i][0]][c.neighbors[i][1]].colour != c.colour){
          if(i==0)
            edges[i] = c;
          else {
          edgesCnt++;
          Cell[] tmp = new Cell[edgesCnt-1];
          for(int j=0; j<edgesCnt-1; j++)
            tmp[j] = edges[j];
          edges = new Cell[edgesCnt];
          edges[edgesCnt-1] = c;
          for(int k=0; k<edgesCnt-1; k++)
            edges[k] = tmp[k];
          }
        }
      }
    }
  }
  
  rest = rest/100;    
  if(edgesCnt!=0){
    for(int i=0; i<100; i++){
      int cell = int(random(edgesCnt));
      int a = edges[cell].x;
      int b = edges[cell].y;
      cellsBuffer[a][b].dislocationDensity += rest;
    }
  }
  else {
    limitReached = true;
    maxIterations = iterationCnt+1;
  }
  rest = 0;
}