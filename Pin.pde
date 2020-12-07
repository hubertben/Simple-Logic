class Pin{

  public int ID = -1;
  public Circuit parent;
  public float x, y;
  public color c;
  public int pin_size_local = pin_size;
  public boolean condition = false;
  public boolean type = false; // True is Input and False is Output
  
  public boolean state = false;
  
  Pin(int ID, Circuit parent, float x, float y, color c, boolean type, boolean condition){
    this.ID = ID;
    this.parent = parent;
    this.x = x;
    this.y = y;
    this.c = c;
    this.type = type;
    this.condition = condition;
  }  
  
  public PShape return_display(){
    PShape pin;
    
    if(this.state){
      c = color(255, 0, 0);
    }else{
      c = color(0, 0, 0);
    }
    
    pin = createShape(ELLIPSE, this.x, this.y, pin_size_local, pin_size_local);
    pin.setFill(this.c); 
    return pin;
  }
  
  public void draw_pin(){ // Used only for inputs and outputs
    if(this.state){
      fill(255, 0, 0);
    }else{
      fill(0, 0, 0);
    }
    
    ellipse(this.x, this.y, this.pin_size_local, this.pin_size_local);
  }
  
  public boolean distance_from_mouse(){
    float x_center = this.x;
    float y_center = this.y;
           
    if(sqrt( pow((mouseX - x_center) ,2) + pow((mouseY - y_center) ,2) ) < this.pin_size_local / 2){
      this.c = color(255, 0, 0);
      return true;
    }else{
      this.c = color(0, 0, 0);
      return false;  
  }
    
  }
  
}
