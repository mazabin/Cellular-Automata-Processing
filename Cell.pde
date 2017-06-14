public class Cell
{
    int x;
    int y;
    color colour;
    
    //Recrystalization variables
    int[][] neighbors;
    int n = 0;
    boolean wasCrystalized;
    int crystalizedAt;
    float dislocationDensity = 1.0;
    
    //MonteCarlo variables
    int numberOfChecks = 0;
    int energy = 0;
    boolean wasChecked = false;
    
    Cell(){
      colour = dead;
      wasCrystalized = false;
    }
}