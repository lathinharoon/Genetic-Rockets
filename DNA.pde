class DNA
{ 
  private ArrayList<Gene> genes = new ArrayList<Gene>();// a list of Genes, which varies depending on the species of rockets.
  
  DNA(int rocket_type)//this constructor is used to generate DNA for the 1st generation of rockets 
  {
     for(int i = 0; i < rocket_type; i++)//a for loop is used to iterate from 0 to the rocket type -1
     {
        genes.add(new Gene());// a new random gene is instantiated, which is then added to the list of Genes.
     }
     genes = bubblesort(genes);// the Genes in the list are also sorted in ascedning order in terms of there angles. 
  }
  
  DNA(String[] thrusters, int[] angles)//This constructor is used when a population is reproduced. 
  //When the string array for the firing pattern and a int array for the genes are passed in from the reproduction class. 
  {
    for(int i = 0; i < angles.length ; i++)//a for loop is used to iterate from 0 to the size of the array -1
    {
      genes.add(new Gene(thrusters[i], angles[i]));//create a new Gene by passing a firing pattern as well as the angle. which is then added to the list
    }
    genes = bubblesort(genes);// the Genes in the list are also sorted in ascedning order in terms of there angles. 
  }
  DNA(String[] thrusters, int[] angles, int a)//This constructor is used when a population is reproduced. 
  //When the string array for the firing pattern and a int array for the genes are passed in from the reproduction class. 
  //however, this constructor is only used in unique circumstances, where the rocket mutates into a new species rocket.
  {
    for(int i = 0; i < angles.length ; i++)//a for loop is used to iterate from 0 to the size of the array -1
    {
      genes.add(new Gene(thrusters[i], angles[i]));//create a new Gene by passing a firing pattern as well as the angle. which is then added to the list
    }
    genes.add(new Gene());//in addition a new random gene is also created and then added to the list of genes.
    genes = bubblesort(genes);// the Genes in the list are also sorted in ascedning order in terms of there angles. 
  }
  
  public void showdetails()//print the genes information on to the console.
  {
    for(int i = 0; i < genes.size(); i++)//this is doneby usge a for loop and calling the showdetails() procedure from that class.
     {
       genes.get(i).showdetails();
     }
  }
  public String savedetails()//returns a string conating all of the genes information.
  {
    String dets = "";
    for(int i = 0; i < genes.size(); i++)
     {
       dets += genes.get(i).savedetails();
     }
     dets = dets.substring(0,dets.length() - 1);//removes the last ',' form the string since thats the last thing thats added to the in the savedeatils() function in the gene class. 
     dets += "\n";//makes a new line for the next rocket
     return dets;
  }
  public int[] getAngles()
  {
    int[] angles = new int[genes.size()];
    for(int i = 0; i < angles.length; i++)
     {
       angles[i] = genes.get(i).getAngle();
     }
     return angles;
  }
  public String[] getThrusters()//returns the thrusters fring patterns in the DNA on an array.
  {
     String[] thruster = new String[genes.size()];
     for(int i = 0; i < thruster.length; i++)
     {
       thruster[i] = genes.get(i).getThruster();
     }
     return thruster;
  }
  public void setPattern(String[] p)//set the firing pattern array thats being passed as the Genes firing pattern for all the genes
  {
    for(int i = 0; i < p.length; i++)
     {
       genes.get(i).thruster = p[i];
     }
  }// this is used during the reprdoduction process.
  public int getRocketType()
  {
    return genes.size();
  }
  public ArrayList<Gene> bubblesort(ArrayList<Gene> vs)// as mentioned in the design, bubble sort will be used to sort the genes in order to make reprodcution more succesfull
  {
    for (int x = 0; x < vs.size(); x++)//the main loop is iterated from 0 to the size of the list -1.
    {//within this for loop, a nested for loop is pressent
      for (int i = 0; i < vs.size()-1; i++)//which iterates from 0 to the size of the list -2.
      {
        if (vs.get(i).getAngle() >= vs.get(i+1).getAngle())//if the gene in the 1st position has a greter angle then the gene that adjacent in the list.
        {
            Gene temp = vs.get(i);
            vs.set(i,vs.get(i + 1));
            vs.set(i + 1 , temp);// swap the Genes position in the list.
        }
      } // this loop is iterated for every single element, length -1 no of times.
    }
    return vs;//returns the sorted list.
  }
 
}
