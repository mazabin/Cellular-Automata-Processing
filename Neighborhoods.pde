int a=0;
int b=0;
  
void getNeighbors(Cell c){
  switch(neighborhood){
    case "moore":
    {
      Moore(c);
    }
    break;
    case "vn":
    {
      VonNeumann(c);
    }
    break;
    case "hexl":
    {
      HexLeft(c);
    }
    break;
    case "hexr":
    {
      HexRight(c);
    }
    break;
    case "hexra":
    {
      HexRandom(c);
    }
    break;
    case "penta":
    {
      PentaRandom(c);
    }
    break;
  }
}

void Moore(Cell c){   
  int neighbors = 0;
  int n=0;
  c.n = 8;
  c.neighbors = new int[8][3];
  for(int i=-1; i<2; i++){
    for(int j=-1; j<2; j++){
      if(i!=0 || j!=0){
        //COORDINATE X
        if((c.x != 0 && c.x != (width/cellSize)-1) || (c.x==0 && i!=-1) || (c.x==(width/cellSize)-1 && i!=1))
           a = c.x+i;
         else if(c.x == 0 && i==-1)
           a = (width/cellSize)-1;
         else if(c.x == (width/cellSize)-1 && i==1)
           a = 0;
          
        //COORDINATE Y
        if((c.y != 0 && c.y != (height/cellSize)-1) || (c.y==0 && j!=-1) || (c.y==(height/cellSize)-1 && j!=1))
           b = c.y+j;
         else if(c.y == 0 && j==-1)
           b = (height/cellSize)-1;
         else if(c.y == (height/cellSize)-1 && j==1)
           b = 0;
         
       if(simulationType.equals("conway")){
         if(cells[a][b].colour != dead)
           neighbors++;           
         }
       else if((simulationType.equals("drx") && growth) || simulationType.equals("monte")){         
          c.neighbors[n][0] = a;
          c.neighbors[n][1] = b;
          c.neighbors[n][2] = cells[a][b].colour; 
          n++;
          if(c.colour == crystalColor && simulationType.equals("drx")){
            cellsBuffer[a][b].colour = c.colour;
            cellsBuffer[a][b].wasCrystalized = true;
            cellsBuffer[a][b].dislocationDensity = 1.0;        
          }
       }
       else{
         if(cells[a][b].colour == dead)       
           cellsBuffer[a][b].colour = c.colour;
       }
      }
    }
  }

  if(simulationType.equals("conway")){
    if(cells[c.x][c.y].colour!=dead){
      if(neighbors < 2 || neighbors > 3){
        cellsBuffer[c.x][c.y].colour = dead;
      }
      else if(neighbors == 2 || neighbors ==3){
        cellsBuffer[c.x][c.y].colour = alive;
      }
    }
    else {
      if(neighbors == 3)
        cellsBuffer[c.x][c.y].colour = alive;
    }   
  }
}

void VonNeumann(Cell c){
  for(int i=-1; i<2; i++){
    for(int j=-1; j<2; j++){
      if(!(i==0 && j==0)){
        if(i*j==0){
          if(bc == 2){
            a = c.x+i;
            b = c.y+j;
            cellsBuffer[a][b].colour = c.colour;
          }
          else if(bc == 1){
            //COORDINATE X
            if(c.x == 0 && i == -1)
              a = (width/cellSize)-1;
            else if(c.x == (width/cellSize)-1 && i == 1)
              a = 0;
            else
              a = c.x+i;
              
            //COORDINATE Y
            if(c.y == 0 && j == -1)
              b = (height/cellSize)-1;
            else if(c.y == (height/cellSize)-1 && j == 1)
              b = 0;
            else
              b = c.y+j;
              
          if(cells[a][b].colour == dead)
            cellsBuffer[a][b].colour = c.colour;
          }
        }
      }
    }
  }
}

void HexLeft(Cell c){
  for(int i=-1; i<2; i++){
    for(int j=-1; j<2; j++){
      if(!(i==0 && j==0)){
        if(i*j!=-1){            //{i=-1, j=1},  {i=1, j=-1}
          if(c.x == 0 && i==-1)
            a = (width/cellSize)-1;
           else if(c.x == (width/cellSize)-1 && i == 1) 
            a = 0;
           else
            a = c.x+i;
            
           if(c.y == 0 && j == -1)
            b = (height/cellSize)-1;
           else if(c.y == (height/cellSize)-1 && j == 1)
            b = 0;
           else
            b = c.y+j;

          if(cells[a][b].colour == dead)
            cellsBuffer[a][b].colour = c.colour;
        }  
      }
    }
  }
}

void HexRight(Cell c){
  for(int i=-1; i<2; i++){
    for(int j=-1; j<2; j++){
      if(!(i==0 && j==0)){
        if(i*j!=1){
          if(c.x == 0 && i==-1)
            a = (width/cellSize)-1;
           else if(c.x == (width/cellSize)-1 && i == 1) 
            a = 0;
           else
            a = c.x+i;
            
           if(c.y == 0 && j == -1)
            b = (height/cellSize)-1;
           else if(c.y == (height/cellSize)-1 && j == 1)
            b = 0;
           else
            b = c.y+j;

          if(cells[a][b].colour == dead)
            cellsBuffer[a][b].colour = c.colour;
        }  
      }
    }
  }
}

void HexRandom(Cell c){
  int side = int(random(100));
  side = side%2;
  if(side == 1)
    HexLeft(c);
  else
    HexRight(c);    
}

void PentaRandom(Cell c){
  int side = int(random(2));
  int x = int(random(2));
  boolean wasChanged = false;
  if(x!=1)
    x=-1;
  
  for(int i=-1; i<2; i++){
    for(int j=-1; j<2; j++){
        if(side == 1 && x!=i){
          if(c.x == 0 && i==-1)
            a = (width/cellSize)-1;
           else if(c.x == (width/cellSize)-1 && i == 1) 
            a = 0;
           else
            a = c.x+i;
            
           if(c.y == 0 && j == -1)
            b = (height/cellSize)-1;
           else if(c.y == (height/cellSize)-1 && j == 1)
            b = 0;
           else
            b = c.y+j;   
            wasChanged = true;
       }
        else if(side == 2 && x!=j){
           if(c.x == 0 && i==-1)
            a = (width/cellSize)-1;
           else if(c.x == (width/cellSize)-1 && i == 1) 
            a = 0;
           else
            a = c.x+i;
            
           if(c.y == 0 && j == -1)
            b = (height/cellSize)-1;
           else if(c.y == (height/cellSize)-1 && j == 1)
            b = 0;
           else
            b = c.y+j;
            wasChanged = true;
        }
        
      if(wasChanged == true && cells[a][b].colour == dead){
          cellsBuffer[a][b].colour = c.colour;
          wasChanged = false;
      }
    }
  }
}