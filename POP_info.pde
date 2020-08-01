class POP_info//primarily used to update the points in the graph
{
  private GPointsArray bfpoints;
  private GPointsArray lfpoints;
  private GPointsArray mfpoints;
  //3 GpointsArray are types of arrays used by the library to store co-ordinates used by the graph to plot the points, its similar to a 2d array. This data structure is takes in the x co-ordinate and the y co-ordinate for each input. There are 3 of the GpointsArray to store the best fitness, mean fitness and low fitness for each generation. 
  POP_info(Population population)// this constructor is used to update the GPointArrays, in turn the graph.
  {
    setSize();// new 3 empty GPointArrays are creted with the size of no. of generation
    Global.best_Fitness.append(population.rocketAt(0).getFitness());
    Global.low_Fitness.append(population.rocketAt(population.populationrocket().size()-1).getFitness());
    float temp = 0;
    for(int i = 0; i < population.populationrocket().size(); i++)
    {
       temp += population.populationrocket().get(i).getFitness();
    }
    Global.mean_Fitness.append(temp/population.populationrocket().size());
    //calculate the best, low, mean fit score and add to the respective Global lists
    drawG();//then copy the list into the GPointsArray
  }
  POP_info()//this constructor is used during the loading process.
  {
    setSize();// new 3 empty GPointArrays are creted with the size of no. of generation
    drawG();//then copy the list into the GPointsArray
  }
  public void drawG()
  {
    for (int i = 0; i < Global.best_Fitness.size(); i++)
    {
     bfpoints.add(i+1, Global.best_Fitness.get(i));
     lfpoints.add(i+1, Global.low_Fitness.get(i));
     mfpoints.add(i+1, Global.mean_Fitness.get(i));
    }//uses a for loop to iterate from 0 to no. of entries in the list
    //within the loop , 2 values are added to the GPointsArray. one is the pos of the value in the list+1 and the other is the vlaue in the list. since the posiotion in the array can help us give info. on what gen the val was added.
  }
  public void setSize()
  {
    int a = Global.generation;
    bfpoints = new GPointsArray(a);
    lfpoints = new GPointsArray(a);
    mfpoints = new GPointsArray(a);
  }
  public GPointsArray bf()
  {
    return bfpoints;
  }
  public GPointsArray lf()
  {
    return lfpoints;
  }
  public GPointsArray mf()
  {
    return mfpoints;
  }
}
