import controlP5.*;
import grafica.*;
ControlP5 cp5;
GPlot plot;
PImage targetimage, ro;
Group g1;
Button begin, reset, Save, SaveObs, Load, LoadObs;
Slider popSize, mutRate, burnTime, velocity;
Toggle adaptive, fitScore, typeObs, displGraph;
Textarea explain;
boolean boot;

Population population;
Rocket best, low;
Reproduction reproduce;
POP_info graph;
ArrayList<Obstacle> obstacles;
PVector obsStrt;
PVector obsEnd;
String details;
int tempBurn;
boolean loadedGen = false;

void setup()
{

  fullScreen(2);//this is used to setup the size of the canvas of the screen. this sets the size of the canvas to the size of the screen.
  background(0);//sets the background to black
  frameRate(30);//frame rate is set to 30Hz.
  
  Global.start = new PVector(width/2, (3*height)/4);// Assigns the Global variable start, a Pvector. this is the start location for the rocket 
  
  targetimage = loadImage("target.png");//load the image of the target in to the PImage varibale.
  Global.target = new PVector(width/2, height/10);// Assigns the Global variable target, a Pvector. this is the target's original location. this is variable will be used to display the target as well for the rockets essential calculation. 
  ro = loadImage("rocket.png");//load the image of the rocket in to the PImage variable. which will be used in the rocket class. To represent each rocket using this image.
  
  obstacles = new ArrayList<Obstacle>();//instantiates a new empty list of obstacles.
  details = "NO INFORMATION AVAILABLE";//set the string regarding previous generation. since on the 1st gen, there is no info for the previous generation.
   
  boot = false;//boot is set to false. since at the start the programe should draw the homepage of the simulation.
  Global.t = new ArrayList<ArrayList<PVector>>();// instantiates an emepty list of list of Pvecotrs.
  
  cp5 = new ControlP5(this); //instantiates the class need for the GUI.
  cp5.setFont(createFont("Calibri", 32));
  cp5.setColorActive(0xffff0000);
  cp5.setColorForeground(0xffff0000);
  cp5.setColorBackground(#001f3f);// sets the fonts as wellas the colours for the GUI controllers. 

  g1 = cp5.addGroup("g1")
       .setLabel("PARAMETERS")
       .setWidth(200)
       .setPosition(10,width/4)
       .setBackgroundColor(color(255,80))
       .setBackgroundHeight(25)
       .activateEvent(true);//create a group by the name g1 and adds it to the GUI. It also sets the poition where its displayed as well as the colour.  
       
  begin = cp5.addButton("begin")
             .setPosition(width/2-40,height/2 - 100)
             .setSize(100,30)
             .activateBy(ControlP5.RELEASE)
             .setGroup(g1);// creates a new button for the begin function. then adds it to the the group g1. this is done so that the user can hide all the feature if he/she wish.
             
  reset = cp5.addButton("reset")
             .setPosition(width/2-40,height/2 -25)
             .setSize(100,30)
             .activateBy(ControlP5.RELEASE)
             .setGroup(g1);// creates a new button for the reset function. then adds it to the the group g1. this is done so that the user can hide all the feature if he/she wish.
  
  Save = cp5.addButton("Save")
             .setPosition(width*3/4,height/10 + 50)
             .setSize(100,30)
             .activateBy(ControlP5.RELEASE)
             .setGroup(g1);// creates a new button for the save function. then adds it to the the group g1. this is done so that the user can hide all the feature if he/she wish.
  
  Load = cp5.addButton("Load")
             .setPosition(width*3/4,height/10 + 150)
             .setSize(100,30)
             .activateBy(ControlP5.RELEASE)
             .setGroup(g1);// creates a new button for the load function. then adds it to the the group g1. this is done so that the user can hide all the feature if he/she wish.
             
 SaveObs = cp5.addButton("SaveObs")
             .setPosition(width*3/4+200,height/10 + 50)
             .setSize(120,30)
             .activateBy(ControlP5.RELEASE)
             .setGroup(g1);// creates a new button for the save obstacle function. then adds it to the the group g1. this is done so that the user can hide all the feature if he/she wish.
             
 LoadObs = cp5.addButton("LoadObs")
             .setPosition(width*3/4+200,height/10 + 150)
             .setSize(120,30)
             .activateBy(ControlP5.RELEASE)
             .setGroup(g1);// creates a new button for the load obstacle function. then adds it to the the group g1. this is done so that the user can hide all the feature if he/she wish.
             
  popSize = cp5.addSlider("popSize")
               .setLabel("POPULATION SIZE")
               .setColorCaptionLabel(0)
               .setPosition(width/15,height/10)
               .setSize(450,30)
               .setRange(50,500)
               .setNumberOfTickMarks(46)
               .setSliderMode(Slider.FIX)
               .setValue(100)
               .setColorLabel(255)
               .showTickMarks(true)
               .setGroup(g1);// create a slider for changing the population size, set the location, range as well as the staring value and how much they increment by. also added to the group
               
  mutRate = cp5.addSlider("mutRate")
               .setLabel("MUTATION RATE")
               .setColorCaptionLabel(0)
               .setPosition(width/15,height/10+80)
               .setSize(300,30)
               .setRange(0,1)
               .setValue(0.5)
               .setColorLabel(255)
               .setGroup(g1);// create a slider for changing the mutation size, set the location, range as well as the staring value and how much they increment by. also added to the group
               
  burnTime = cp5.addSlider("burnTime")
                .setLabel("BURN TIME")
                .setColorCaptionLabel(0)
                .setPosition(width/15,height/10+160)
                .setSize(300,30)
                .setRange(5,100)
                .setValue(30)
                .setColorLabel(255)
                .setGroup(g1);// create a slider for changing the burn time, set the location, range as well as the staring value and how much they increment by. also added to the group
  
  velocity = cp5.addSlider("velocity")
               .setLabel("VELOCITY")
               .setColorCaptionLabel(0)
               .setPosition(width/15,height/10 + 240)
               .setSize(300,30)
               .setRange(0,10)
               .setNumberOfTickMarks(11)
               .setSliderMode(Slider.FIX)
               .setValue(1)
               .setColorLabel(255)
               .setGroup(g1);// create a slider for changing the velocity, set the location, range as well as the staring value and how much they increment by. also added to the group
  
  adaptive = cp5.addToggle("adaptive")
                .setLabel("ADAPTIVE MUTATION")
                .setColorCaptionLabel(0)
                .setPosition(width/2,height/10 + 50)
                .setValue(false)
                .setColorLabel(255)
                .setSize(70,30)
                .setGroup(g1);//create a toggle for the adaptive mutation feature. set the initial value to false then added to the group.
                
 fitScore = cp5.addToggle("fitScore")
               .setCaptionLabel("FITNESS SCORE")
               .setColorCaptionLabel(0)
               .setPosition(width/2,height/10 +150)
               .setSize(70,30)
               .setValue(false)
               .setColorLabel(255)
               .setGroup(g1);//create a toggle for displaying fitness score.set the initial value to false then added to the group.
               
 typeObs = cp5.addToggle("typeObs")
                .setCaptionLabel("OBSTACLE TYPE")
                .setColorCaptionLabel(0)
                .setPosition(120,width/4 - 100)
                .setSize(70,30)
                .setValue(true)
                .setColorLabel(255);//create a toggle for switching between the different types of obstacles. however this is not added to the group since this should be always visible.
                
 explain = cp5.addTextarea("explain")
              .setText("")
              .setPosition(width*3/4 -50,8*height/10-80)
              .setSize(380,270);// create the textarea which will be used to descirbe the features.
              
  grp();// subroutiine which will be used to create a new graph.
  
  displGraph = cp5.addToggle("displGraph")
                .setLabel("GRAPH")
                .setColorCaptionLabel(0)
                .setPosition(10,width/4 - 100)
                .setSize(70,30)
                .setValue(false)
                .setColorLabel(255);//create a toggle for displaying the obstacle. however this is not added to the group since this should be always visible.
}

void draw()// draw subroutine which will be used to draw the homepage as well as the simulation.
/*
Called directly after setup(), the draw() function continuously executes the lines of code contained inside its block until the program is stopped.
The number of times draw() executes in each second may be controlled with the frameRate() function.
*/
{
  background(0);//to clear the contents of the window, after each iteraion has been completed. 
  imageMode(CENTER);
  image(targetimage,  Global.target.x,  Global.target.y, 70, 70);// draws the image of the loaded target at the specified loaction.
  for(int i = 0; i< obstacles.size(); i++){obstacles.get(i).dis();}//uses a for loop to iterate from 0 to no.of obstcales -1 to draw the obstacles in the list of obastcles onto the window.
  if(!boot)//if boot is flase draw the homepage.
  {
    fill(255);
    textFont(createFont("Bodoni MT Bold", 72));
    textAlign(CENTER, CENTER);
    text(" GENETIC       ROCKETS",  width/2, height/12);//draws the title of the simulation
    
    fill(#01FF70);
    textFont(createFont("Calibri Bold", 35));
    textAlign(CENTER, TOP);
    text("Genetic Programming (GP) is a type of Evolutionary Algorithm. Evolutionary Algorithms are used \n"
         +"to discover solutions to problems humans do not know how to solve, directly. Free of human preconceptions or biases,\n"
         +"the adaptive nature of EAs can generate solutions that are comparable to, and often better than the best human efforts. Genetic\n"
         +"rockets provide an elegant example of genetic algorithms. In the beginning the rockets doesn't know how to reach the target,\n"
         +"after each generation, the rocket evolve into better genomes which in general gets closer to finding a solution.",width/2,height/6 -20);// a brief description about the program
    
    
    if(cp5.isMouseOver(adaptive))
    {
      explain.setText("If active, the mutation rate is raised when all the rockets arent able to find the path. However,if atleast 1/5 of the population reaches the target mutation rate is reduced to less then 0.2.");
    }
    if(cp5.isMouseOver(fitScore))
    {
      explain.setText("Display the fitness score of each rocket.");
    }
    if(cp5.isMouseOver(typeObs))
    {
      explain.setText("Draw a rectangle obstacle when true and a circle when false");
    }
    else if(!cp5.isMouseOver())
    {
      explain.setText("");
    }//when the user hovers over the feature buttons and toggles the textarea "explain" will write a small description
  }
  else//if boot is set to true, draws the simulation page.
  {
   fill(#03FF69);
   textSize(18);
   textAlign(TOP, TOP);
   text("Generation: "+ Global.generation, 0, 0);// prints the number of the current Generation
   text("Current Population Size: "+ population.populationrocket().size() , 0, 22);// prints the size of the current population.
   text(details,0,44);//writes details about the previous generation, on the top left of the window.
   if(Global.generation > 1 && !loadedGen){best.display();low.display();}
   //displays the best and worst rocket from the previous population next to the details about the previous population. but will only dsplay them if the generation is not loaded or the Generation > 1.
   //since its not possible to get the best & worst rocket if the gnerartion is loaded or if its ht 1st gen 
   if(frameCount >= (round(frameRate)*Global.burn_time) -1 || population.getnoOfDeadRockets() == Global.population_size || population.getnoOfSuccRockets() == Global.population_size || population.getnoOfDeadRockets() + population.getnoOfSuccRockets() == Global.population_size )
   /*
   generation ending criteria:
   exceeding burn time: so if the framecount = to the frame rate * burn time
   or if all the rockets are dead
   or if all the rockets reached the target
   or if the all the rockets either died or reached the target
   */
   {// start the generation ending procedure.
     Global.burn_time = tempBurn; // set the tempburn as the Global burntime
     population.order();// order the population of rocket interms of their fitness score. biggest to smallest in the list.
     population.printPopFitnesss();//print the fitness score of the population in the console.
     
     details = population.population_info();//calculate tthe deatils regarding the generation that ended. best, low, mean fitness scores which species of rocket was the best and the lowest. and then store in to the details
     best = population.rocketAt(0);//assigns the best rocket which is in the 1st position of the list in the population to the "best" rocket variable
     Global.t.add(new ArrayList<PVector>(best.returnTrail()));// adds the trail of the best rocket to the Global list of list of PVectors.
     low = population.rocketAt(population.rocket.size()- 1);//assigns the worst rocket which is in the last position of the list in the population to the "low" rocket variable
     best.pos= new PVector(100, 120);
     low.pos= new PVector(100, 255);//sets the position of the rocket at the top left corner of the window, so they can be displayed next to the details of the previous generation window
     
     graph = new POP_info(population);// creates a new instance of the POP_info which calculates the mean fitness as well get the best and the lowest fitness score.
     //adds them to the global lists of best,mean and low fitness. then generates GPointsArray for the plots. 
     plot.setPointColor(0);
     plot.setPoints(graph.bf());
     plot.addLayer("low fitness", graph.lf());
     plot.getLayer("low fitness").setPoints(graph.lf());
     plot.getLayer("low fitness").setLineColor(#F70F0F);
     plot.addLayer("mean fitness", graph.mf());
     plot.getLayer("mean fitness").setPointColor(#0F1CF7);
     plot.getLayer("mean fitness").setLineColor(#0F1CF7);
     plot.getLayer("mean fitness").setPoints(graph.mf());// since i ll be plotting 3 diferent points for every x value, i am making 2 more layers for the mean and low fitness, which plots thepoint son the grpah 
     
     Global.adaptive = adaptive.getBooleanValue();// gets the value of the adaptive toggle button and assigns the value to the Global adaptive bool which is needed in the next step. 
     reproduce = new Reproduction(population);//creates a new instance of reprodcuction class by passing the currnet population, to reproduce and build a new population
     population = reproduce.returnPop();//get the new population fromm the reproduction class and assing them as the main population.
     population.showdetails();//print the deatils about them to the console.
     frameCount = 0;// set the frame count to 0, in order to reset the current time as well reneder generation critira null i.e.exceeding burn time.
     loadedGen = false; // set it to false since the population has be reproduced and new generation will start.
     Global.generation++;//increments the Generation
     redraw();  //call the draw() subroutine again 
   }
   else//this is drawn every other time unless the generation ending criteria has been met.
   {
      Global.currentTime = int(frameCount/frameRate);//calculate the current time by dividing the frame count by frame rate
      int time = Global.burn_time - Global.currentTime;
      text("TIME REMAINING: " + time, 0, 350);//caluclate and display time remaining before the generation ends.
      for(int x = Global.t.size() -1 ; x >= 0; x--)
      {
        stroke(#FE12FF);
        ArrayList<PVector> trail = Global.t.get(x);
        for(int i = 0; i < trail.size()-1;i++)
        {
          line(trail.get(i).x, trail.get(i).y, trail.get(i+1).x, trail.get(i+1).y);
        }
      }// use a for loop to draw the trails of the bestrocket from the previous gen. which are stried in the global list of list of rockets
      population.checkCollPop(obstacles); //pass in the obstacle list to check for any rockets in the population that collided with obstacle or flew out of the window and classify those rocket dead  
      population.movePopulation();// move the rockets in the population according to their DNA.
      population.displayPopulation();// display those rockets in the population.
      population.order();// order the population of rocket interms of their fitness score. biggest to smallest in the list.
      population.rocketAt(0).displayline();//get the best rocket and higlight the rocket by drawing a line from the target to the rocket
      smooth();
      population.rocketAt(0).displayTrail();//get the best rocket and draw a trail fo r the path it has travelled
     
      if(fitScore.getBooleanValue()){ population.displayPopulationFitness();}//get the toggle value of the fitscore toggle if its true display the fitness score of the rocket on the window
      if(displGraph.getBooleanValue()){drwgrp();}//get get the toggle value of the dsiplGraph toggle if its true display the Graph on the window. drawgrp() is a subroutine which is uesd to draw the graph
    }
  }
}
public void begin()// this subroutine is called everytime the begin button is pressed, this is used to start the simulation of rockets
{
  Global.burn_time = tempBurn;// set the tempburn as the Global burntime, which is essential in making DNA and GENE
  population = new Population(Global.population_size);  // create a new instnace of the population class. this constructor creates completely random population of rockets.
  //it would be equally made up of rockets from species ranging from 1  to 5. 
  population.showdetails(); //prints the details of the poulation into the console
  Global.generation = 1;//set the Gloabl generation count to 1
  boot = true; //set boot = true, which means the draw function will start drawing the simulation of rockets instead of the homepage.
  frameCount = 0;//set the frame count to 0, in order to reset the current time.
  begin.hide();//hides the begin button since, after starting the simulation button, there is no point of the begin button.
}
public void reset()// this subroutine is called everytime the reset button is pressed, this is used to return the user to the homepage.
{
  Global.best_Fitness = new FloatList();
  Global.low_Fitness = new FloatList();
  Global.mean_Fitness = new FloatList();//resets the Global list of best, mean and low fitness which is used to draw the graph.
  frameCount = 0;//set the frame count to 0, in order to reset the current time.
  setup();// calls the setup() subroutine which is called on the beginning of the simulation. to reset all variables. this includes boot which is set to false so draw will draw the homepage
  begin.show();// show the begin button, which would be hiddden if the user clicked begin before.
}
public void Save()// this subroutine is called when the user clicks the save button.
/*
this save method saves the:
  the users prefernces, features eneabled,
  the list of best mean and low fit scores
  the obstacles
  the rockets information i.e. gene and DNA.
*/
{
  PrintWriter output = createWriter("data/save.txt");//create a text file callled "save.txt" 
  String bfs = "";
  String lfs = "";
  String mfs = "";//before the Gloabl lists can be stored they have to be converted into strings.
  for(int i = 0; i<Global.best_Fitness.size();i++)
  {
     bfs += str(Global.best_Fitness.get(i)) +",";
     lfs += str(Global.low_Fitness.get(i)) +",";
     mfs += str(Global.mean_Fitness.get(i)) +",";
  }//add the values in the list to the string. each entry seperated by a ','
  bfs = bfs.substring(0, bfs.length() - 1);
  lfs = lfs.substring(0, lfs.length() - 1);
  mfs = mfs.substring(0, mfs.length() - 1);//remove the last ',' since when loading the list theyll need to be split. so removing the last ',' is critical.
  output.println(Global.mutationRate+","+Global.velocity+","+Global.adaptive+","+displGraph.getBooleanValue());//prints the changes made by the user and the features enabled to the text file 
  output.println(bfs);//prints the string which holds the best fit scores.
  output.println(lfs);//prints the string which holds the lowest fit scores.
  output.println(mfs);//prints the string which holds the mean fit scores.
  output.println(obstacles.size());//prints the no.of obstacles in the simulation. this is essintiall to load the obstacles when the user loads the generation.
  //this will be used to make a for loop to add the obstacles
  for(int i = 0; i < obstacles.size(); i++)
  {
    output.println(obstacles.get(i).shape+","+obstacles.get(i).x1+","+obstacles.get(i).y1+","+obstacles.get(i).x2+","+obstacles.get(i).y2);
    //for every iteration, a single obstacle is stored on a single line. for each obstacle :
    //its shape, the x,y coordinate when the user strted drawing as well as x,y coordinate when the user finished drawing will be stored.
  }
  output.println(population.getDetails());//population.getDetails() retrieved information about every rocket in the population in the list. Refer to Population Class
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
}
public void SaveObs()// this subroutine is called when the user clicks the saveobs button. this stores a layout of obstacle
{
  PrintWriter output = createWriter("data/saveObs.txt"); //create a text file callled "saveObs.txt" 
  output.println(obstacles.size());//prints the no.of obstacles in the simulation. this is essintiall to load the obstacles when the user loads the generation.
  //this will be used to make a for loop to add the obstacles
  for(int i = 0; i < obstacles.size(); i++)
  {
    output.println(obstacles.get(i).shape+","+obstacles.get(i).x1+","+obstacles.get(i).y1+","+obstacles.get(i).x2+","+obstacles.get(i).y2);
     //for every iteration, a single obstacle is stored on a single line. for each obstacle :
    //its shape, the x,y coordinate when the user strted drawing as well as x,y coordinate when the user finished drawing will be stored.
  }
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
}
public void LoadObs()//this subroutine is called when the loadObs button is clicked. 
//this subroutine will be used to load layout of obstacles saved.
{
  obstacles = new ArrayList<Obstacle>();//create a new empty list of obstacles 
  String[] lines = loadStrings("data/saveObs.txt");//load the save file into a string array, where each entry represent each line 
  char s;
  float x1, y1, x2, y2;//5 variables for properties which descirbe the obstacle.
  for(int x = 1; x<lines.length ;x++)
  {//Starting from one the full loop iterates to the link of the length of the array -1. at each iteration :
    String[] f = split(lines[x], ",");//each line is split into a string array by a ‘,’.
    s =  f[0].charAt(0);//The first value in the array is the character wht type it is.
    x1 = float(f[1]);
    y1 = float(f[2]);
    x2 = float(f[3]);
    y2 = float(f[4]);//the x,y coordinate when the user strted drawing as well as x,y coordinate when the user finished drawing
    obstacles.add(new Obstacle(new PVector(x1,y1),new PVector(x2,y2), s));
    //Using this information a new instance of an obstacle class is created. this obstacle is then added to the obstacle list 
  }
 }
public void Load()// this subroutine is used to load an entire generation that being save.
{
  grp();// clear the graph by creating a new instance of the graph.
  obstacles = new ArrayList<Obstacle>();//create a new empty list of obstacles 
  Global.best_Fitness = new FloatList();
  Global.low_Fitness = new FloatList();
  Global.mean_Fitness = new FloatList();//resets the Global list of best, mean and low fitness which is used to draw the graph.
  population = new Population();// create an empty population.
  String[] thrusters;
  int[] angles;// these will be used to store the retrieved Genes of the rockets. Angle and the firirng pattern seperately.
  int popSizeof = 0;//holds the size of the pop.
  String[] lines = loadStrings("data/save.txt");//load the save file into a string array
  for (int i = 0 ; i < lines.length; i++) 
  {//in the string file each line represent different vlaues and difeerne variables.
    if(i == 0)// the 1st line holds the information about the parameters changed by the user
    {
      String[] f = split(lines[i], ",");//each line is split into a string array by a ‘,’.
      Global.mutationRate = float(f[0]);// the 1st entry is the mutation rate
      popSize.setValue(Global.mutationRate);
      Global.velocity = int(f[1]);// the next is the velocity.
      velocity.setValue(Global.velocity);
      Global.adaptive = Boolean.parseBoolean(f[2]);//the next is a boolean value for the adaptive mutation
      adaptive.setValue(Global.adaptive);
      displGraph.setValue(Boolean.parseBoolean(f[3]));//the final one is a boolean value for displaying the graph
    }
    else if(i==1)//the next line holds the best fitness list
    {
      String[] f = split(lines[i], ",");//each line is split into a string array by a ‘,’.
      for(int x = 0; x<f.length ;x++)
      {
        Global.best_Fitness.append(float(f[x])); //each entry is converted into a float then appended to the Global best fit score list
      }
        Global.generation = f.length;// the global generation is set as the length of the list. since the no.of entries in the list is directly proportinal to the generation count.
      
    }
    else if(i==2)//the next line holds the lowest fitness list
    {
      String[] f = split(lines[i], ",");//each line is split into a string array by a ‘,’.
      for(int x = 0; x<f.length ;x++)
      {
        Global.low_Fitness.append(float(f[x]));//each entry is converted into a float then appended to the Global lowest fit score list
      }
    }
    else if(i==3)//the next line holds the mean fitness list
    {
      String[] f = split(lines[i], ",");//each line is split into a string array by a ‘,’.
      for(int x = 0; x<f.length ;x++)
      {
        Global.mean_Fitness.append(float(f[x]));//each entry is converted into a float then appended to the Global mean fit score list
      }
    }
    else if(i==4)// this line will hold the no. of obstacles in the simulation
    {
      int nu = int(lines[i]); //converts to int
      char s;
      float x1, y1, x2, y2;
      for(int x = 0; x<nu ;x++)//a for loop is iterated from 0 to the no. of obstacels saved which is stored in the variable "nu". 
      {
        i++;
        String[] f = split(lines[i], ",");//each line is split into a string array by a ‘,’.
        // i is incremented and the next line is chosen and split into a string array. since the original line only contained the no. of obstcales,
        //where the following lines hold the inforamtion regaridng the obstacles.
        s =  f[0].charAt(0);//The first value in the array is the character wht type it is.
        x1 = float(f[1]);
        y1 = float(f[2]);
        x2 = float(f[3]);
        y2 = float(f[4]);//the x,y coordinate when the user strted drawing as well as x,y coordinate when the user finished drawing
        obstacles.add(new Obstacle(new PVector(x1,y1),new PVector(x2,y2), s));
        //Using this information a new instance of an obstacle class is created. this obstacle is then added to the obstacle list 
      }
    }
    else//all the other lines holds genetic infromation regarding the rocket.
    {
       popSizeof++;//the pop size increase.
       String[] pieces = split(lines[i], ",");//each line is split into a string array by a ‘,’.
       int type = int(pieces[0]);//for each rocket, the 1st value is the number of thruster the rockets have, followed by the genes, which are the firing pattern and the angle.
       Global.burn_time = pieces[1].length();
       tempBurn = pieces[1].length();//set the burntime since burn time and temp burn time is the same as the length of the firing time.
       thrusters = new String[type];
       angles = new int[type];//instantiate the arrays with size of the rocket type.
       int x= 0 , y = 0;
       for(int a = 1; a < pieces.length ; a++)
       /*
       after the rocket type, the firing pattern and the angles are placed in alternating order.
       so the 1st entry in the array will be stored as the array, where as the 2nd entry as the angle.
       so in order to takle this issue, for all the odd value of a, they will by stored in x and for the even values of a will be stored in the angle array. 
       */
       {
        if(a%2 == 1)
        {
          thrusters[x] = pieces[a];
          x++;
        }
        else
        {
          angles[y] = int(pieces[a]);
          y++;
        }
       }
      DNA dna= new DNA(thrusters, angles);//once the genes are added, a new DNA is created using the 2 arrays.
      population.addRocket(new Rocket(dna));// the new DNA is then used to make a new instance of the rocket. which is added to the population
      // this process iterated untill the for loop ends.
    }
  }
    population.showdetails();//prints the details of the population
    Global.population_size = popSizeof;
    popSize.setValue(popSizeof);
    burnTime.setValue(Global.burn_time);
    Global.population_size = popSizeof;//updates the population size as well as update the sliders
    
     graph = new POP_info();//create a new instance of the POP_info class which will update the GPonitsArray with the new updated lists.
     plot.setPointColor(0);
     plot.setPoints(graph.bf());
     plot.addLayer("low fitness", graph.lf());
     plot.getLayer("low fitness").setPoints(graph.lf());
     plot.getLayer("low fitness").setLineColor(#F70F0F);
     plot.addLayer("mean fitness", graph.mf());
     plot.getLayer("mean fitness").setPointColor(#0F1CF7);
     plot.getLayer("mean fitness").setLineColor(#0F1CF7);
     plot.getLayer("mean fitness").setPoints(graph.mf());//plotting the 3 different plot in different layers
     
    loadedGen = true;// set true
    details = "NO INFORMATIOIN AVAILABLE";//no infor available since this is a loaded gen
    boot = true;//if the draw function is till on the homepage, move to the simulation page.
    Global.t = new ArrayList<ArrayList<PVector>>();// empty the list of list of PVectors.
    frameCount = 0;//set the frame count to 0, in order to reset the current time.
    redraw();//call the draw() funtion
}
public void popSize(int size)// this is called when a popSize slider event is triggered i.e. the user has chnaged the slider.
{
  Global.population_size = size;//the argument that was passed in will be set as the Global population size.
}
public void mutRate(float val)// this is called when a mutRate slider event is triggered i.e. the user has chnaged the slider.
{
  Global.mutationRate = val;//the argument that was passed in will be set as the Global mutation Rate.
}
public void burnTime(int time)// this is called when a burnTime slider event is triggered i.e. the user has chnaged the slider.
{
  tempBurn = time;//the argument that was passed in will be set as the temp burn time and will be set as the global burn time just before the reproduction takes place.
}
public void velocity(float vel)// this is called when a velocity slider event is triggered i.e. the user has chnaged the slider.
{
  Global.velocity = vel;//the argument that was passed in will be set as the Global velocity.
}

void mouseClicked()
{
 if (mouseButton == RIGHT && !g1.isOpen()) //the user has the ability to change the loaction of the target by right clicking where they want to move it.
 // however, it can only work if the group is closed, this reduces any accidental changes the user can make 
 {
   Global.target = new PVector(mouseX, mouseY);//set the target to the mouses location
 }   
}
void mousePressed()
{
  if (!g1.isOpen()) //in order to draw an obstacle into the simulattion the user has to press the mouse and drag it to the required position.
 {
  obsStrt = new PVector(mouseX, mouseY);// whne the user clicks to draw the obstacle, the obsStrt stores the PVector of the mouse location.
 }
}
void mouseReleased()
{
  if (!g1.isOpen()) 
 {
  obsEnd = new PVector(mouseX, mouseY);// and when the mouse is released, the obsEnd PVector stores the location of the mouse again.
  if(typeObs.getBooleanValue())//get the value of the typeObs toggle, if true draw a rect obstacle.
  {
   obstacles.add(new Obstacle(obsStrt,obsEnd, 'r'));//the x,y coordinate when the user strted drawing as well as x,y coordinate when the user finished drawing as well as the char 'r'
   //is used to make new obstacle which is added to the list of obstacle.
  }
  else//if the value of the typeObs toggle is false draw rectangle obstacle
  {
    obstacles.add(new Obstacle(obsStrt,obsEnd, 'c'));//the x,y coordinate when the user strted drawing as well as x,y coordinate when the user finished drawing as well as the char 'c'
   //is used to make new obstacle which is added to the list of obstacle.
  }
  
 }
}
void keyPressed()//if any keyboard is pressed
{
  if (key == 'f') {
    Load();
  }
  else {
  obstacles = new ArrayList<Obstacle>();//delete all the obstacle and create a new empty list.
  }
}
void grp()//this subroutine is used to create a new Graph.
{
  plot = new GPlot(this);//create a new instance
  plot.setPos(width - 600, 0);
  plot.setDim(500, 500);//set dimension as well the eposition
  
  plot.setTitleText("FITNESS");
  plot.getXAxis().setAxisLabelText("GENERATION");
  plot.getYAxis().setAxisLabelText("FITNESS SCORE");
  plot.activatePointLabels();
  plot.activateZooming();//set the title as well, x, y axis titles. also, enable zooming
}
void drwgrp()//called in the Draw() funtion to draw the actual graph on to the window.
{
  plot.beginDraw();
        plot.drawBackground();
        plot.drawBox();
        plot.drawXAxis();
        plot.drawYAxis();
        plot.drawTopAxis();
        plot.drawRightAxis();
        plot.drawTitle();
        plot.drawPoints();
        plot.drawLines();
        plot.drawLabels();
        plot.drawGridLines(GPlot.BOTH);
        plot.endDraw();
        fill(0);
        ellipse(width - 550, 20, 20,20);
        text(" - Best Fitness score", width - 535, 10);
        fill(#F70F0F);
        ellipse(width - 550, 575, 20,20);
        text(" - Low Fitness score", width - 535, 565);
        fill(#0F1CF7);
        ellipse(width - 180, 20, 20,20);
        text(" - Mean Fitness score", width - 165, 10);//drawing legends for the graph.
}
