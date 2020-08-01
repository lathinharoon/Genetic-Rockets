class Population
{
  private ArrayList<Rocket> rocket = new ArrayList<Rocket>();//list of rockets, which holds the all the rockets in the population
  
  Population()//constructor will be used for population that is produced using reproduction or loading from a saved file. 
  {
  
  }
  
  Population(int population)//to create an instance of population class for the 1st generation of rockets. 
  {
    int rocket_type = 5;// fr the 1st gen, there ll be 20% of rockets from each species ranging 1 to 5
    for(int i = 0; i < 5; i++)//iterates 5 time to create 5 diiferent species.
    {
      //starts with the rockets with 5 thruster and decremnts
      for(int a = 0; a < population/5; a++)//for 20% of the population
      {
         rocket.add(new Rocket(Global.IDCounter, rocket_type));//create new instance of rockets of that species then add it to the list of rockets
         Global.IDCounter++;
      }
     rocket_type--;//when one iteration is completed the rocket type decrements, to make 20% of rockets with 4 thrusters.
    }
  }
  
  public ArrayList<Rocket> populationrocket()
  {
    return rocket;
  }
  public Rocket rocketAt(int i)//get the rocket at the index of i
  {
      return rocket.get(i);
  }
  
  public void addRocket(Rocket roc)//adds a rocket to the list of rocket, this is the main way a rocket is added to the population during reproduction as well as loading.
  {
    roc.setID(Global.IDCounter);//set the ID of the rocket using the global varibale IDcounter
    rocket.add(roc);//add the rocket to the list
    Global.IDCounter++;//increment the global variable IDcounter
  }
  
  public void showdetails()//prints the details of all the rockets in the population.
  {
    for(int i = 0; i < rocket.size(); i++)
     {
       println("the rocket has " + rocket.get(i).getRocketType() + " thrusters");
       rocket.get(i).showdetails(); 
       println();
     }
  }
  
  public String getDetails()//returns all the details about all the rockets in the population
  {
    String details ="";
    for(int i = 0; i < rocket.size(); i++)// for each rocket
     {
       details += rocket.get(i).getRocketType() +",";
       details += rocket.get(i).getDetails();//there will be:the rocket type, the DNA i.e. the Genes, printed in the order of the firing pattern then the angle.
     }
     details.trim();
     details = trim(details);//removes blank lines at the end.
     return details;
  }
  public void displayPopulation()// used to display the rockets in the population on the simulation window
  {
    for(int i = 0; i < rocket.size(); i++)
     {
       rocket.get(i).display();
     }
  }
  
  public void movePopulation()// used to move the rockets in the population on the simulation window
  {
    for(int i = 0; i < rocket.size(); i++)
     {
       rocket.get(i).move();
     }
  }
  
  public void displayPopulationFitness()// used to display the fit score of rockets in the population on the simulation window
  {
    for(int i = 0; i < rocket.size(); i++)
     {
       rocket.get(i).displayFitness();
     }
  }
  public void checkCollPop(ArrayList<Obstacle> obstacles)// used to check if any rocket collided with the obstacle or went out of bounds in the population on the simulation window
  {
    for(int i = 0; i < rocket.size(); i++)
     {
       rocket.get(i).checkDead(obstacles);
     }
  }
  public void order()//will be used to call the sorting algorithem and then assign the sorted list of rocket as the main list.
  {
    ArrayList<Rocket> sortfitness = quickSort(rocket);
    rocket = sortfitness;
  } 
  public ArrayList<Rocket> quickSort(ArrayList<Rocket> roc)//passes in a list of rockets
  {
    int size = roc.size();
    float pivot = 0;
    int ind = size/2;
    int i;
    if (size<=1) //base case when the size of the list is 1 or less, return the list
    {
     return roc;
    } 
    else
    {
       ArrayList<Rocket> L = new ArrayList<Rocket>(); //create a new empty list for the left side of the list i.e. before pivot
       ArrayList<Rocket> R = new ArrayList<Rocket>(); //create a new empty list for the right side of the list i.e. after pivot
       ArrayList<Rocket> sorted = new ArrayList<Rocket>();// create a new empty lift for the sorted list.
       pivot = roc.get(ind).fitness;// get the fitness score of the pivot rocket, i.e. the rocket thats in the middle of the list.
       for (i=0;i<size;i++) //a for loop that iterates from 0 the length of the list -1 .
       {
        if (i!=ind)//skips the pivot position
        {
          if (roc.get(i).fitness>pivot)//if the rocket at i has higher fit score then the pivot rocket add it to the left list
          {
            L.add(roc.get(i));
          }
          else// if it has a smaller fitness score add it to the right list
          {
            R.add(roc.get(i));
          }
        }
       }
      L = quickSort(L);
      R = quickSort(R);//by recursion call the same function to sort the left and right lists,
      //once the lists has been sorted
      sorted = L;
      sorted.add(roc.get(ind));
      sorted.addAll(R);//join the left side of the list then, the pivot then the right side.
      return sorted;//return the sorted list.
    }
  }
    
  public void printPopFitnesss()// used to prin the fit score of rockets in the population on the console window
  {
   for(int i = 0; i < rocket.size(); i++)
   {
      println(rocket.get(i).ID + ": " + rocket.get(i).fitness);
   }
  }
  
  public String population_info()// this function is called at the end of the generation.
  {//this caclulates some essential information regarding the genereation. which are: best fit score, best rocket type, worst fit score, worst rocket type, mean fit score, no of successful rocket 
    float best_Fitness = rocket.get(0).getFitness();//fitness score of best rock
    int rocketTypeOfBest =  rocket.get(0).getRocketType();//rocket type of best rock
    float low_Fitness = rocket.get(rocket.size()-1).getFitness();//fitness score of worst rock
    int rocketTypeOfWorst = rocket.get(rocket.size()- 1).getRocketType();//rocket type of worst rock
    float temp = 0;
    for(int i = 0; i < rocket.size(); i++)
    {
       temp += rocket.get(i).getFitness();
    }
    float mean_Fitness = temp/Global.population_size;//calculates the mean fit score of pop
    int succesRockets = getnoOfSuccRockets();// no of rockets that reached the target
    String det= "";
    det= "BEST FITNESS SCORE IS: " + best_Fitness+".\nTHE BEST ROCKET TYPE HAS: " + rocketTypeOfBest+ " THRUSTERS.\n\n\n\nTHE WORST FITNESS SCORE IS: "+low_Fitness+ ".\nTHE WORST ROCKET TYPE HAS " +rocketTypeOfWorst + " THRUSTERS.\n\n\n\nTHE MEAN FITNESS SCORE IS: "+ mean_Fitness+".\nNUMBER OF ROCKETS THAT REACHED THE TARGET: " + succesRockets;
    return det;
  }
  
  public int getnoOfSuccRockets()
  {
    int count = 0;
    for(int i= 0; i < rocket.size(); i++)
    {
      if(rocket.get(i).hitTarget)
      {
        count++;
      }
    }
    return count;
  }
  
  public int getnoOfDeadRockets()
  {
    int count = 0;
    for(int i= 0; i < rocket.size(); i++)
    {
      if(rocket.get(i).dead)
      {
        count++;
      }
    }
    return count;
  }
} 
