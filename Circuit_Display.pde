

class Circuit_Display{
  public String name = "";
  public float x, y, h, w;
  public Pin_Display[] inputs;
  public Pin_Display[] outputs;
  
  public int bitboard[];
  
  Circuit_Display(String name, int x, int y, int input_count, int output_count, int[] bitboard){
    this.name = name;
    this.x = x;
    this.y = y;
    
    
    this.bitboard = bitboard;
    
    
    this.h = Math.max(input_count, output_count) * 20 + 40;
    this.w = ((name.length()) * 13.5) + 40;
      
    inputs = new Pin_Display[input_count];
    outputs = new Pin_Display[output_count];
    
    for(int i = 0; i < input_count; i++){ 
      inputs[i] = new Pin_Display(x, (y + ((h / input_count)/2)) + (i * (h / input_count)), color(0, 0, 0));  
    }
    
    for(int i = 0; i < output_count; i++){
      outputs[i] = new Pin_Display(x + w, (y + ((h / output_count)/2)) + (i * (h / output_count)), color(0, 0, 0));  
    }
  }
  
  public boolean mouseOn(){
    if(mouseX >= this.x && mouseX <= this.x+this.w && mouseY >= this.y && mouseY <= this.y+this.h){
      return true;
    }
    return false;
  }
  
  public void update_pins(){
    for(int i = 0; i < this.inputs.length; i++){
      inputs[i].x = x;
      inputs[i].y = (y + ((h / this.inputs.length)/2)) + (i * (h / this.inputs.length));
      
    }
    
    for(int i = 0; i < this.outputs.length; i++){
      outputs[i].x = this.x + this.w;
      outputs[i].y = (y + ((h / this.outputs.length)/2)) + (i * (h / this.outputs.length));  
       
    }
  }
  
  public float r = random(100), g = random(100), b = random(100);
  
  public void display(){
    update_pins();
    PShape board = createShape(GROUP);
    
    PShape base = createShape(RECT, this.x, this.y, this.w, this.h);
    base.setFill(color(r, g, b));
    board.addChild(base);

    for(int i = 0; i < this.inputs.length; i++){   
      board.addChild(this.inputs[i].return_display());
    }
    
    for(int i = 0; i < this.outputs.length; i++){
      board.addChild(this.outputs[i].return_display());
    }
    
    
    shape(board);
    fill(255, 255, 255);
    strokeWeight(0);
    textSize(22);
    textAlign(CENTER, CENTER);
    text(this.name, this.x + (this.w/2), this.y + (this.h/2));
  }
  
}

class Pin_Display{

    public float x, y;
    public color c;
    public int pin_size_local = pin_size;

   Pin_Display(float x, float y, color c){

    this.x = x;
    this.y = y;
    this.c = c;

  }  
  
  public PShape return_display(){
    PShape pin;
    c = color(0, 0, 0);
    pin = createShape(ELLIPSE, this.x, this.y, pin_size_local, pin_size_local);
    pin.setFill(this.c); 
    return pin;
  }

}
