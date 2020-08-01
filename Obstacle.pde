class Obstacle
{
  private float x1, y1, x2, y2, radius;
  private char shape;
 
  Obstacle(PVector obsStrt, PVector obsEnd, char s)//to create obstacles you need 2 vectors as well as a char.
  {
     shape = s;
     x1 = obsStrt.x;
     y1 = obsStrt.y;
     x2 = obsEnd.x;
     y2 = obsEnd.y;
     radius = dist(x1, y1, x2, y2);//using pythagoras to calculate the distance between the location where the user click the mouse and where the user released the mouse. only used by the circle
  }
  public void dis()// used to draw the obstacle on the screen
  {
    fill(#A09C9D);
    stroke(255);//colour of the obstacle and the stoke colour
    if(shape == 'r')// if obstacle is a rectangle
    {
      rectMode(CORNERS);//rectMode(CORNERS) interprets the first two parameters of rect() as the location of one corner, and the third and fourth parameters as the location of the opposite corner.
      rect(x1, y1, x2,y2);
    }
    else
    {
       ellipseMode(RADIUS);  //  the first two parameters of ellipse() as the shape's center point, uses the third and fourth parameters to specify half of the shapes's width and height.
       ellipse(x1, y1, radius, radius);
    }
  }
  
}
