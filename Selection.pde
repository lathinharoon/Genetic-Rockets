class RhouletteSelection//this class is used in the crossover class. this is usesd to slec tthe parents for crossover.
//therefore, without this class its impossible for the crossover process to begin.
{
  private float totalFitness = 0;
  private float range = 0;
  private Population pop;// population that will be passed in assigned to this property
  private ArrayList<Rocket> rocketSelection;// the rockets from the population will be stored here
  private float[] size;//an array which will store the fitness proportionate of the population 
  RhouletteSelection(Population population)//constructor takes in the previous population as an argument. 
  {
    pop = population;
    rocketSelection = population.populationrocket();
    for(int i = 0 ; i < rocketSelection.size() ; i++)
    {
      totalFitness +=  rocketSelection.get(i).getFitness();
    }//calculate the total fitness
    
    size = new float[rocketSelection.size()]; //create an empty float array of the size of the population
    for(int i = 0 ; i < rocketSelection.size() ; i++)
    {
     size[i] = calcRange(rocketSelection.get(i).getFitness());
     // for every rocket a fitness proportinate range is calculate using the calcRange method, and then stored in the array designated for each rcoket.
    } 
  }
  public float calcRange (float fitness)//this method caclulates a fitness proportinate range by passing in the fitnes of the rocket.
  {
    range += 360*(fitness/totalFitness); //range is caclulated by adding the previous range with proportiante fitenss of the argument.
    return range;
  }
  public Rocket selectParent(float Rndselect)// this method is used to select a parent for crossover using fitness proportinate selection.
  //a random number is passed in as the argument.
  {
    int position = 0;
    for(int i = 0 ; i < rocketSelection.size() ; i++)
    {// for every range in the fitness proprotionate array
      if(size[i] >= Rndselect)// if the value at position i is greater then the random float
      {
        position = i;//set position = i
        return pop.rocketAt(position);//return the rocket at the psotion 
      }
    }
   return pop.rocketAt(position);
  }
}  
