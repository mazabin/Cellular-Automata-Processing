int cellSize = 5;
int newWidth = width/cellSize;
int newHeight = height/cellSize;
boolean resized = false;

void resizeBoard(){
  pause = true; //<>//
     while(newWidth%cellSize!=0){
       newWidth++;
     }
     while(newHeight%cellSize!=0){
       newHeight++;
     } //<>// //<>// //<>// //<>// //<>//
}

color crystalColor = color(112, 112, 112);
color[] cArray = new color[15];
void setColours(){
  cArray[0] = color(247,202,201);     
  cArray[1] = color(66,133,244);
  cArray[2] = color(251,188,5);
  cArray[3] = color(52,168,83);
  cArray[4] = color(234,67,53);
  cArray[5] = color(85,172,238);
  cArray[6] = color(41,47,51);
  cArray[7] = color(225,232,237);
  cArray[8] = color(123,0,153);
  cArray[9] = color(255,153,0);
  cArray[10] = color(255,180,255);
  cArray[11] = color(255,204,0);
  cArray[12] = color(164,198,57);
  cArray[13] = color(228,113,122);
  cArray[14] = color(154,78,174);
}