class Reproduction//this class is reponsible for creating a new popultion usng multiple reprdouction methods
{
  private int eliteChildren;
  private int mutateChildren;
  private int crossChildren;
  private Population children = new Population();//creates an empty new population
  private Population population;
  Reproduction(Population population)//this constructor takes in population that has already ended.
  {
    Global.IDCounter = 0;// the id counter is reset //<>//
    population.order();
    this.population = population;//the population that was passed in is assigned to the varibale "population".
    int popsize = Global.population_size;
    eliteChildren = int(popsize*0.1);
    mutateChildren = int(popsize*0.4);
    crossChildren = popsize - eliteChildren - mutateChildren;//calculate the the number of rockets produced from each reproduction.
    if(Global.adaptive)//if adaptive mutation is on and if the no of rockets reached the target is 0 set mutation rate to 0.7 and if the no of rockets reached the target is > 0.25 population, 
    //mutation rate is set to 0.09
    {
     if(population.getnoOfSuccRockets() == 0)
     {
       Global.mutationRate = 0.7;
     }
     else if(population.getnoOfSuccRockets() >= Global.population_size/4)
     {
       Global.mutationRate = 0.09;
     }
    }
    mutRate.setValue(Global.mutationRate);
    elite();
    mutate();
    crossover();
    //calls the elite, crossover and mutate methods
    ArrayList<Rocket> childrenRocket = children.populationrocket();// once every rocket has been added to the new population.
    //for every rocket,  their firirng pattern's length will be same as the last population.
    //however, the user could change the burn time, so if the user did change the burn time we have to trim the firing pattern or increase the firng pattern 
    for(int i = 0; i < childrenRocket.size(); i++)// for every rocket in the population
    {
      Rocket r = childrenRocket.get(i);
      String[] thrust = r.thrusters();//get their firing pattern
      for(int x= 0; x < r.getRocketType(); x++)//for every thruster in the rocket
      {
        //if the firing patten is longer then the burn time, trim the strings.using substrings.
        if(thrust[x].length() >= Global.burn_time)thrust[x] = thrust[x] = thrust[x].substring(thrust[x].length()-Global.burn_time);
        //if the burn time is greater then the length of the firirng pattern. use a random number generator similar to the one that was used by the gene constructor to increase the length of the string
        else
        {
          for(int y = thrust[x].length(); y<Global.burn_time; y++)
          {
            char temp = char(int(random(0,2))+48);
            thrust[x] += temp;
          }
        }
      }
      r.setThrusterPattern(thrust);//the modified string array is then set as the new string for the genes for the rocket.
    }
  }
  public void elite()//this method will be used to create 10% of the population
  {
    for(int i = 0; i < eliteChildren; i++)// a loop which iterates from 0 to elitechildren - 1.
    {
      Rocket eliteRocket = population.rocketAt(i);//gets the rocket at position i
      String[] thrusters = eliteRocket.thrusters();
      int[] angles = eliteRocket.angles();//retrieves thruster patterns and angles.
      DNA dnaEliteChild = new DNA(thrusters, angles);// create a new DNA using the firing pattern arrays as well as the angle array.
      children.addRocket(new Rocket(dnaEliteChild));//create a new Rocket, which is then added the poulation
    }
  }
  public void mutate()//this method will be used to create 40% of the population
  {
   
    Rocket mutating = population.rocketAt(0);//choose the best rocket
    Mutate mut = new Mutate(mutating, mutateChildren);//create an instance of the mutate class, which takes the best rocket and the number of rockets needed to produce.
    ArrayList<Rocket> Mutated = mut.Rockets();//get the reproduced rockets.
    for(int i = 0; i< mutateChildren; i++)
    {
      children.addRocket(Mutated.get(i));
    }//then add the rockets to the population
  }
  public void crossover()//this method will be used to create 50% of the population
  {
    Crossover c = new Crossover(population,crossChildren);//create an instance of the mutate class, which takes the population and the number of rockets needed to produce.
    ArrayList<Rocket> rs = c.rockets();//get the reproduced rockets.
    for(int i = 0; i< rs.size(); i++)
    {
      children.addRocket(rs.get(i));
    }//then add the rockets to the population
    
  }
  public Population returnPop(){return children;}//returns the new population
}
