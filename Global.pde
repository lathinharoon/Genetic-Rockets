static class Global
{
  static int IDCounter = 0;//id counter which is used to hold the id of the rockets in the population
  static PVector start = new PVector();
  static PVector target = new PVector();//Pvector of the start and target location
  static int burn_time;// the burn time of the gen
  static float velocity = 1;// velocity of the rockets
  static int population_size = 100;//the population size
  static float mutationRate = 0.5; //mutation rate
  static int generation = 1;//generation count
  static boolean adaptive = false;//bool to hold if adapt. mutation is on/ off
  static FloatList best_Fitness = new FloatList();
  static FloatList low_Fitness = new FloatList();
  static FloatList mean_Fitness = new FloatList();//hold the best, low, mean fit scores of the populations
  static PImage rocImage;//image of the rocket
  static int currentTime;// current time of the generation
  static ArrayList<ArrayList<PVector>> t;// list of list of PVectors used to hold the trails of best rockets
}
