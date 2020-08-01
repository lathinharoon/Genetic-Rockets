class Gene//user defined data type, represents a thruster, 
{
  String thruster = "";//holds a firing pattern
  private int angle;//angle
  Gene()// contructor to generate a random Gene i.e. thruster
  {
    for(int i = 1 ; i <= Global.burn_time; i++) //a for loop that iterates from 1 to the Global burn time to create a random firing pattern 
    {
      char temp = char(int(random(0,2))+48);//random genereator to choose between o and 1 then convert it ninto ascii by adding 48 then turing it into a character
      thruster += temp;//this character is then added to the the string thruster
    }
    angle = int(random(0,360));// choose a random angle sung a random number generator between o and 360.
  }
  Gene(String thrusterChild, int angleChild)//constructor where the angle and the firing pattern is passsed during instantiation.
  // this is usually done during the reprdoduction/ loading a population processs.
  {
    thruster = thrusterChild;
    angle = angleChild;//set thearguments passed in as the properties.
  }
  public String getThruster() { return thruster; }
  public int getAngle() { return angle; }
  public void showdetails()// used to print the genes info into the console.
  {
    println(getThruster());
    println(getAngle());
  }
  public String savedetails()// used during the saving process.
  {  
    String info = "";
    info += getThruster() +",";
    info += getAngle()+",";//thruster is added to the string then the angle, which is seperated by the ','.
    return info;//which is then returned
  }  
}
