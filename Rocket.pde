class Rocket
{
  private int ID;
  private DNA dna;
  private PVector pos = new PVector(Global.start.x,Global.start.y);
  private PVector vel = new PVector();
  private PVector prevel = new PVector(); 
  private boolean hitTarget = false;
  private boolean dead = false;
  private float fitness = 0f;
  private PImage roc = ro;// the pimage roc is assigned the image ro which was loaded an image of the rocket in the simulate section
  private ArrayList<PVector> trail = new ArrayList<PVector>();
 
  Rocket(int ID, int rocket_type)//is used to produce the 1st generation of rockets. 
  //This constructor takes in arguments for the id and the type of rocket. This is then used to create a new random DNA. 
  {
    this.ID = ID;//sets the id equal
    dna = new DNA(rocket_type);//creates a new Random DNA
    trail.add(new PVector(pos.x, pos.y));//add the current position of the rocket which is the strt location to the list. 
  }
  Rocket(DNA dna)
  {
    this.dna = dna;// assign the reprodued dna as the DNA of the rocket
    trail.add(new PVector(pos.x, pos.y));//add the current position of the rocket which is the strt location to the list. 
  }
  public void showdetails(){  dna.showdetails();}// prints the detail of the rocket by calling the showdeatils() method of the DNA
  
  public String getDetails(){ return dna.savedetails();}//returns the details of the rocket obe saved
  
  public int getRocketType(){ return dna.getRocketType();}
  
  public String[] thrusters(){return dna.getThrusters();}
  
  public int[] angles(){return dna.getAngles();}
  
  public DNA getDNA(){ return dna;}
  
  public void setID(int a){ID = a;}
  
  public void setThrusterPattern(String[] pattern){dna.setPattern(pattern);}//set the firingg patterns for the genes within the DNA ny the strings thats being passed in 
  
  public void display()//this method is used to draw the rocket in the simulation window.
  {
   // 1st the main body of the rocket will be displayed.
   /*
     every time the rocket is dispalyed, the main body of the rocket will be pointed towards the direction of the velocity i.e. the way the rocket is moving.
     in order for that to be succesfull the image roc will have to be applied transformation.
   */
   imageMode(CENTER);// dteremines how the paremters are interpreted, the 2nd and 3rd arguments are the position of the centre of the rocket.
   pushMatrix();//Pushes the current transformation matrix onto the matrix stack, pushMatrix() function saves the current coordinate system to the stack.
   //so the transformation can be applied freely without affecting other objects.
   translate(pos.x,pos.y);// inorder for the rockets body to be rotated to the direction of motion, the grid has to be moved to the current position of the rocket since,
   rotate(atan2(prevel.y, prevel.x)+PI/2);//coordinates are always rotated around their relative position to the origin. refer information regarding prevel at the move()
   //once the grid has been roated to the required angle. using artan(opp/adj)
   image(roc, 0, 0, 20, 40);// the image is drawn, the x,y coordinates are 0,0 since the grid has be tranlsated to the current position of the rocket.
   popMatrix();//Pops the current transformation matrix off the matrix stack,  popMatrix() restores the prior coordinate system.
   noStroke();
   String[] thrusters = dna.getThrusters();//gets the firing patterns for the thrusters i.e. Gene
   int[] angles = dna.getAngles();//gets the angles for the thrusters i.e. Gene
   for (int i = 0; i < angles.length; i++)//for every thruster in the rocket
   {
     String thrusterTemp = thrusters[i];//get thefring pattern for that specfic thruster
     if(dead == true || hitTarget == true){fill(#FFFFFF);}// if the thruster is ded or hitTarget colour the thruster white.
     else if(thrusterTemp.length() > Global.currentTime && thrusterTemp.charAt(Global.currentTime) == '1'){fill(#FA0808);}//if the thruster is firing i.e. charchetr at index(currenttime) ==1
     //colour the thruster red.
     else{fill(#0811FA);}// if not firing, colour blue will be the thruster's colour.
     //each thruster is represented by a thin rectangle, which is rotated to the appropriate angle according to the Gene. 
     pushMatrix();
     translate(pos.x,pos.y); 
     rotate(radians(angles[i]+90));// get the angle of the thruster, convert ot raidans, rotate to the appropriate direction
     rect( 0, 0, 1, 40);//draw the rectangle
     popMatrix();//pop matrix
     
   }
  }
  
  public void move()
  { 
   checkHit();// chcke if the rocket reched the target,
   if(!dead && !hitTarget)//if the rocket didnt crash or reach the target
   {
   vel.set(0,0);//set the vel = 0, since the velocity is calculated every farme using the DNA, fring patterns of the rockte and added to the pos.
   int[] angles = dna.getAngles();
   String[] thrusters = dna.getThrusters();//gets the firing patterns and the angle for the thrusters i.e. Gene
   for (int i = 0; i < angles.length; i++)//for every thruster
   {
    PVector thrusterVector =  PVector.fromAngle(radians(angles[i])); // get the angle of the thruster. convert to radians and then form a PVector using the angle.
    thrusterVector.normalize();//noramlise so the magnitude is 1.
    String thrusterTemp = thrusters[i];// get the firing pattern of the thruster
    if(thrusterTemp.length() > Global.currentTime && thrusterTemp.charAt(Global.currentTime) == '1')// if the thruster is firing  i.e. charchetr at index(currenttime) == 1
    {
     vel.x += Global.velocity*thrusterVector.x;//multiply the x comp of the angle vector by the Global velocity and add it to the velocity x comp
     vel.y += Global.velocity*thrusterVector.y;//multiply the y comp of the angle vector by the Global velocity and add it to the velocity y comp 
    }
   }
   pos.add(vel);//then add the velocity to the position of the rocket
   if(vel.mag() != 0)
   {
     prevel.set(vel);//one of the problems with rotating the rockets body to the direction of motion is, when the rockets vel = 0, the rocket dirction is
     //returns to the original angle which is horizontal. this is however, unrealistic, since rockets dont just turn back to their previous direction when they stop firing.
     // therefore, if the vel = o, the prevel stays unchanged i.e. previous value of the vel. the prevel vector will be used to rotate, so it doent return to the original position.
     trail.add(new PVector(pos.x, pos.y));//adds the position of the rocket to the trail list.
   }
   
   fitness = calcFitness();//fitness of the rocket is calculated and assigned
  }
 }
  
  public void checkHit()//check collsion between the rocket and the target
  {
    float d = dist(pos.x , pos.y ,  Global.target.x ,  Global.target.y);//using pythagoras to calculate the distance between the rocket and the target location.
    if(d < 35)//if less the 35
    {
      hitTarget = true ;
    }
    else
    {hitTarget = false;}
  }
  
  public void checkDead(ArrayList<Obstacle> obstacles)//check collision between obstacles as well as the screen bounds
  {
    if (pos.y < 0) //if the rocket travels outside of the screen, they are declared dead.
    {
      dead = true;
    }
    else if (pos.y > height) 
    {
      dead = true;
    }
    else if (pos.x > width) 
    {
      dead = true;
    }
    else if (pos.x < 0) 
    {
       dead = true;
    }
    for(int i = 0; i < obstacles.size(); i++)//for every obstacle in the list that  was passed in as an argument
    {
      if( obstacles.get(i).shape == 'r')//obstacle type is a rectangle
      {
        if(pos.x >= obstacles.get(i).x1 && pos.x <= obstacles.get(i).x2 && pos.y >= obstacles.get(i).y1 && pos.y <= obstacles.get(i).y2)
        //if the rockets x pos is greter then the obstacle left corner and less then obstacles roght corner
        //and the rockets y po is greater then the top corner and less then the bottom corner
        {
          dead = true;
        }
      }
      else// if the obstacle is a circle
      {
       float d = dist(pos.x , pos.y , obstacles.get(i).x1, obstacles.get(i).y1);//using pythagoras to calculate the distance between the rocket and the obstcale centre
        if(d <= obstacles.get(i).radius)//it its less then or equal to the radius
        {
          dead = true ;
        }
      }
    }
    
  }
  public float calcFitness() //calculating fitness of the rocket.
  {
    float distance = dist(pos.x, pos.y,  Global.target.x,  Global.target.y);//using pythagoras to calculate the distance between the rocket and the target location.
    if(hitTarget){distance = 34;}//if the rocket reached the target, set the distance = 1; this is ude to some rocket might get closer to the rocket at later time but
    //due to their DNA might get closer to the target. so might get a higher fitness score then the rocket that reached the traget first.
    float x = 1000 /distance;
    float tempfitness = pow(x,0.8);
    if (dead) {tempfitness /= 2;}
    if (hitTarget) { tempfitness += 1000/frameCount;}
    return tempfitness;// reurn the fitness score
  }
  public float getFitness()
  {
    return fitness;
  }
  
  public void displayFitness()// displays the fitness score of the rocket next to the rocket on the simulation, if the user enables the feature.
  {
    textSize(11);
    fill(#DB5DFF);     
    if(width/2 < pos.x)
    {
     text(ID + ":"+ fitness, pos.x - 20, pos.y); 
    }
    else
    {
     text(ID + ":"+ fitness, pos.x + 20, pos.y);  
    }
  }
  
  public void displayline()//display a straight line from the rocket to the target. only used by the best rocket. used to highlight the best rocket. 
  {
    stroke(255);
    line(pos.x,pos.y,Global.target.x,  Global.target.y);
  }
  
  public void displayTrail()//displays the trail of the rocket, which it path it followed to reach that position. only used by the best rocket
  {
    stroke(#2BED13);
    for(int i = 0; i < trail.size()-1;i++)
    {
      line(trail.get(i).x, trail.get(i).y, trail.get(i+1).x, trail.get(i+1).y);
    }
  }
  public ArrayList<PVector> returnTrail()
  {
    return trail;
  }
}
