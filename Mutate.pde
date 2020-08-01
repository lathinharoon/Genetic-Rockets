class Mutate// class which is responsible for mutation 
{
  private float chanceOfhavingNewThruster = 0.05;// this number is the chance that the new mutated rocket will mutate into a new species or not 
  private ArrayList<Rocket> childRockets = new ArrayList<Rocket>();
  //a list of rockets which will hold the offsprings 
  Mutate(Rocket rocket, int numberRocket)//the constructor takes in the best rocket and the number of offsprings needed 
  {
   String[] thrusters = rocket.thrusters();
   int[] angles = rocket.angles();
   //the firing pattern array and the angle array are retieved.
   for(int i = 0; i < numberRocket; i++)//for every rocket this loop is iterated 
   {
       String[] newThrusters = new String[thrusters.length];
       int[] newAngles = new int[angles.length];
       //create a new thruster firing pattern array of the same size as well
       //as an angle array of the same size as the parent. 
       for(int a = 0; a < rocket.getRocketType(); a++)//a for loop which iterates for species of the parent.
       {
        newThrusters[a] =  mutThruster(thrusters[a]);// a muatted version of thruster pattern is assigned to the new array at the same position as the parent.
        newAngles[a] = mutAngle(angles[a]);// a muatted version of angle is assigned to the new angle array at the same position as the parent.
       }
       DNA dnaChild;// an object of DNA
       if(random(0,1) <= chanceOfhavingNewThruster){dnaChild = new DNA(newThrusters, newAngles,1);}
       //If the random generator produces a number that is less than the chance of having a new thruster a new DNA will be created with an extra gene which means it will be mutated into a new rocket 
       else{dnaChild = new DNA(newThrusters, newAngles);}//if eles it would create a new rocket of the same type
       childRockets.add(new Rocket(dnaChild)); //this DNA is then used ot create a rocket wg=hich is then added to the list.
     
   }
  }
  
  public String mutThruster(String thrusterPattern)
  //this function is called from the constructor to mutate the firing pattern that’s being passed in as the argument and then return a mutated firing pattern
  {
    String newThruster = "";//an empty string
    for(int i = 0; i < thrusterPattern.length(); i++)//iterates from 0, length of the thruster - 1.
    {
      char temp = thrusterPattern.charAt(i);//the char at i
      float rand = random(0,1);
      if(rand <= Global.mutationRate && temp == '0')
      {
        newThruster += '1';
      }
      else if(rand <= Global.mutationRate && temp == '1')
      {
        newThruster+='0';
      }
      else
      {
        newThruster += temp;
      }
      /*
      if the random no. is less the mutation rate set by the user, the character for the child thruster at that 
      position will be the opposite to the character 
      */
    }
    return newThruster;
  }
  
  public int mutAngle(int angle)
  {//function is called from the constructor to mutate the angle of the thruster 
  
    float temp = 360*Global.mutationRate;//caclulate the range the angle can vary
    float rnd = random(-temp,temp);//chosse a random number between neagitve of the number and the positive
    return int(angle+rnd);//retunr the number thats athe random number to the angle.
  }
  public ArrayList<Rocket> Rockets()
  {
    return childRockets;
  }
}
