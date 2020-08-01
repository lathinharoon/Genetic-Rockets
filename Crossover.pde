class Crossover//this class would be responsible for reproducing offspring using crossover 
{
  Population population;//assigns the population thats being passedin
  ArrayList<Rocket> offsprings = new ArrayList<Rocket>();//holds the rockets thats produced using the crossover methods.
  Crossover(Population p, int crossChildren)//the constructor takes in the population from where the parents are chosen and the number of offsprings needed 
  {
    population = p;
    for(int i = 0; i < crossChildren; i++)//iterates for the number of offsprings needed.
    {
      ArrayList<Rocket> Parents = Selecting();//call the selecting method to return 2 parents
      String[] thrustersp1 = Parents.get(0).thrusters();
      int[] anglesp1 = Parents.get(0).angles();//get the 1st parents angles and the firing patterns
      String[] thrustersp2 = Parents.get(1).thrusters();
      int[] anglesp2 = Parents.get(1).angles();//get the 2nd parents angles and the firing patterns
      
      int typeOfrocket;
      boolean secondRocketisbigger;
      boolean sametype;
      int prevburn = thrustersp1[0].length();
      
      if(Parents.get(0).getRocketType() < Parents.get(1).getRocketType())
      {
        typeOfrocket = Parents.get(1).getRocketType();
        secondRocketisbigger = true;
        sametype  =false;
      }
      
      else if(Parents.get(0).getRocketType() == Parents.get(1).getRocketType())
      {
        typeOfrocket = Parents.get(1).getRocketType();
        sametype = true;
        secondRocketisbigger =false;
      }
      
      else
      {
        typeOfrocket = Parents.get(0).getRocketType();
        secondRocketisbigger = false;
        sametype = false;
      }//the comparison methods determine, which rockets have more number of thrusters or if the rockets are of the same species
      //as well as, the rocket type of the offspring is determined
      
      String[] thrustersChild = new String[typeOfrocket];// set it as an empty string
      int[] anglesChild = new int[typeOfrocket];//new instances of empty array with the size of rocket type
      //since, the offspring will be the same species as the rocket with the most no. of rockets  
      if(secondRocketisbigger)
      {     
        for(int z = 0; z < Parents.get(0).getRocketType();z++)//for every thruster the smaller rockets has
        {
          int temp = anglesp1[z];//get the 1st rockets angle for the thruster.
          int closestdiffer = 360;
          int thrusterPos = 0;
          for(int x = 0; x < Parents.get(1).getRocketType(); x++)
          {//for very thruster in the 2nd rocket
            int diff = abs(temp - anglesp2[x]);//get the difference between that angle and the angle of the thruster of the 1st rocket
            if (diff<closestdiffer)//if tht difference is smaller then the previous closest difference
            {
              closestdiffer = diff;//the diff is set as the closest difference
              thrusterPos = x; // set the position of the thruster as the Gene positon which is chosen to cross
            }
          }// the above algorithem will be used to find the thruster in the second rocket with the similar thruster placement around the rocket.
          //this is done to make sure that the genes that combined is similar
          
          int temp2 = anglesp2[thrusterPos];//get the angle at the  chosen pos
          anglesChild[z] = (temp + temp2)/2;//get the average as the combined angle
          
          String tempS1 = thrustersp1[z];
          String tempS2 = thrustersp2[thrusterPos];//thruster pattern for the gene for the 1st and 2nd rocket  
          float f1 = Parents.get(0).getFitness();
          float f2 = Parents.get(1).getFitness();// the fitness of the both rockets
          thrustersChild[z] = "";//set the firing pattern empty for the offspring
          
          for(int b = 0; b < prevburn; b++)//for the burntime of the prevoius gen
          {
            float rnd = random(0,1);//get a random no.
            if(tempS1.charAt(b) == tempS2.charAt(b))//if both char are the same at the index
            {
              if(rnd <= 0.7)//if the rnd no. <= 0.7
              {
                thrustersChild[z] += tempS1.charAt(b);//add the char to the string
              }
              else
              {
                 thrustersChild[z] += opp(tempS1.charAt(b));//add the opposit char to the string
              }
            }
            else if(f1 >= f2)
            {
             thrustersChild[z] +=  tempS1.charAt(b);//if the char are not the same, add the character, where the rocket of the char has bigger fitness score 
            }
            else
            {
               thrustersChild[z] +=  tempS2.charAt(b);
            }           
          }
         }
         for(int z = Parents.get(0).getRocketType(); z < typeOfrocket;z++)// for the rest of the thrusetrs that havent been produced using crossover
         {
           anglesChild[z] = anglesp2[z];
           thrustersChild[z] = thrustersp2[z];
           //get the thruster pattern as well as the angle of the thrusters that are left form the bigger parent and assign them to the offspring's array
         }
       }
       else if(sametype)// if both parents aare of the same type
       {
         for(int z = 0; z < typeOfrocket;z++)//for every thruster in any of the 2 parent rockets
         {
            anglesChild[z] = (anglesp1[z] + anglesp2[z])/2;//get the avg.
            String tempS1 = thrustersp1[z];
            String tempS2 = thrustersp2[z];//thruster pattern for the gene for the 1st and 2nd rocket 
            float f1 = Parents.get(0).getFitness();
            float f2 = Parents.get(1).getFitness();// the fitness of the both rockets
            thrustersChild[z] = "";//set the firing pattern empty for the offspring
            for(int b = 0; b < prevburn; b++)//for the burntime of the prevoius gen
            {
              float rnd = random(0,1);
              if(tempS1.charAt(b) == tempS2.charAt(b))//if both char are the same at the index
              {
               if(rnd <= 0.7)//if the rnd no. <= 0.7
               {
                thrustersChild[z] += tempS1.charAt(b);//add the char to the string
               }
               else
               {
                 thrustersChild[z] += opp(tempS1.charAt(b));//add the opposit char to the string
               }
             }
             else if(f1 >= f2)
             {
              thrustersChild[z] +=  tempS1.charAt(b);//if the char are not the same, add the character, where the rocket of the char has bigger fitness score 
             } 
             else
             {
               thrustersChild[z] +=  tempS2.charAt(b);
             }
            } 
         }
       }
       else//if the 1st rocket is bigger
       {
         for(int z = 0; z < Parents.get(1).getRocketType();z++)//for every thruster the smaller rockets has
         {
          int temp = anglesp2[z];//get the 2nd rockets angle for the thruster.
          int closestdiffer = 360;
          int thrusterPos = 0;
          for(int x = 0; x < Parents.get(0).getRocketType(); x++)
          {//for very thruster in the 1st rocket
            int diff = abs(temp - anglesp1[x]);//get the difference between that angle and the angle of the thruster of the 2nd rocket
            if (diff<closestdiffer)//if tht difference is smaller then the previous closest difference
            {
              closestdiffer = diff;//the diff is set as the closest difference
              thrusterPos = x; // set the position of the thruster as the Gene positon which is chosen to cross
            }
          }// the above algorithem will be used to find the thruster in the first rocket with the similar thruster placement around the rocket.
          //this is done to make sure that the genes that combined is similar
          int temp2 = anglesp1[thrusterPos];
          anglesChild[z] = (temp + temp2)/2;//get the average as the combined angle
          
          String tempS1 = thrustersp1[thrusterPos];
          String tempS2 = thrustersp2[z];//thruster pattern for the gene for the 1st and 2nd rocket 
          float f1 = Parents.get(0).getFitness();
          float f2 = Parents.get(1).getFitness();// the fitness of the both rockets
          thrustersChild[z] = "";//set the firing pattern empty for the offspring
          for(int b = 0; b < prevburn; b++)//for the burntime of the prevoius gen
           {
              float rnd = random(0,1);
              if(tempS1.charAt(b) == tempS2.charAt(b))//if both char are the same at the index
              {
               if(rnd <= 0.7)//if the rnd no. <= 0.7
               {
                thrustersChild[z] += tempS1.charAt(b);//add the char to the string
               }
               else
               {
                 thrustersChild[z] += opp(tempS1.charAt(b));//add the opposit char to the string
               }
             }
             else if(f1 >= f2)
             {
              thrustersChild[z] +=  tempS1.charAt(b);//if the char are not the same, add the character, where the rocket of the char has bigger fitness score 
             } 
             else
             {
               thrustersChild[z] +=  tempS2.charAt(b);
             }
           }
        } 
         for(int z = Parents.get(1).getRocketType(); z < typeOfrocket;z++)// for the rest of the thrusetrs that havent been produced using crossover
         {
           anglesChild[z] = anglesp1[z];
           thrustersChild[z] = thrustersp1[z];
           //get the thruster pattern as well as the angle of the thrusters that are left form the bigger parent and assign them to the offspring's array
         }
       }
      DNA dnaCrossChild = new DNA(thrustersChild, anglesChild);// create a new DNA using the firing pattern arrays as well as the angle array.
      offsprings.add(new Rocket(dnaCrossChild));//create a new Rocket, which is then added the list off rcokets
    }
  }
  public ArrayList<Rocket> Selecting()//this method is used, used to select 2 parents from the population for a crossover
  {
    float selectionNum1 = random(0, 360);
    float selectionNum2 = random(0, 360);// 2 random numbers gnerated between o and 360, which will be used to find the parents
    ArrayList<Rocket> ParentsForCrossing = new ArrayList<Rocket>();//create an empty list
    RhouletteSelection select = new RhouletteSelection(population); //instantiate the rhoulette selection, which would calculate all the the fitness proportionate selection
    Rocket Parent1 = select.selectParent(selectionNum1);
    Rocket Parent2 = select.selectParent(selectionNum2);// pass the random number generated to the select parent method to choose 2 parenst and then add it to the list.
    ParentsForCrossing.add(Parent1);
    ParentsForCrossing.add(Parent2);
    return ParentsForCrossing;//return the list
  }
  public char opp(char t)// returns the opposite char of the one that was passed in.
  //if 1 is passed in return 0, vice versa
  {
    if(t == '1'){return '0';}
    return'1';
  }
  public ArrayList<Rocket> rockets(){return offsprings;}
}
