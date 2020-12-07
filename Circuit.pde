
class Circuit {
  
  public String name = "";
  public float x, y, h, w;
  public Pin[] inputs;
  public Pin[] outputs;
  
  public int bitboard[];
  
  Circuit(String name, int x, int y, int input_count, int output_count, int[] bitboard){
    this.name = name;
    this.x = x;
    this.y = y;
    
    if(bitboard == null){
      this.bitboard = new int[(int)pow(2, input_count)]; 
    }else{
      this.bitboard = bitboard;
    }
    
    this.h = Math.max(input_count, output_count) * 20 + 40;
    this.w = ((name.length()) * 13.5) + 40;
      
    inputs = new Pin[input_count];
    outputs = new Pin[output_count];
    
    for(int i = 0; i < input_count; i++){ 
      inputs[i] = new Pin(i, this, x, (y + ((h / input_count)/2)) + (i * (h / input_count)), color(0, 0, 0), true, false);  
    }
    
    for(int i = 0; i < output_count; i++){
      outputs[i] = new Pin(i, this, x + w, (y + ((h / output_count)/2)) + (i * (h / output_count)), color(0, 0, 0), false, false);  
    }
     
  }
  
 
  
  public void update_signal(){

    int sum = 0;
    for(int i = 0; i < this.inputs.length; i++){
      if(this.inputs[i].state){
        sum += pow(2, i);
      } 
    }
    
    String o = (binary(this.bitboard[sum]));
    o = new StringBuilder(o).reverse().toString();
    for(int i = this.outputs.length - 1; i >= 0; i--){
       
       if(o.charAt(i) == '0'){
         this.outputs[i].state = false;
       }else{
         this.outputs[i].state = true;
       }
    }
    
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
    textSize(22);
    textAlign(CENTER, CENTER);
    text(this.name, this.x + (this.w/2), this.y + (this.h/2));
       
  }
  
  public void update_position(float x, float y){
    this.x = x;
    this.y = y;
  }

}
