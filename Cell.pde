public class Cell
{
    int x;
    int y;
    color colour;
    int[][] neighbors;
    int n = 0;
    boolean wasCrystalized;
    int crystalizedAt;
    float dislocationDensity = 1.0;
    
    Cell(){
      colour = dead;
      wasCrystalized = false;
    }
}