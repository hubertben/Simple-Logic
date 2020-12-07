 

public int throttle = 0;

public int bisection_height = 650;

public String new_circuit_name = "";
public int pin_size = 15;
public ArrayList<Circuit> board = new ArrayList<Circuit>();
public ArrayList<Link> connections = new ArrayList<Link>();
public ArrayList<Button> buttons = new ArrayList<Button>();


public Storage storage = new Storage();

public Pin[] inputs = new Pin[8];
public Pin[] outputs = new Pin[8];

public ArrayList<Pin> inputs_inUse = new ArrayList<Pin>();
public ArrayList<Pin> outputs_inUse = new ArrayList<Pin>();

public Pin current_pin;

void setup(){
  size(1680, 900);
  noStroke();
  strokeWeight(5);

  
  draw_IO();

  buttons.add(new Button("CREATE", 10, 660, 100, 40, "create"));
  buttons.add(new Button("CLEAR LINKS", 120, 660, 150, 40, "clear"));
  buttons.add(new Button("UNDO CONNECTION", 280, 660, 250, 40, "clear"));
 
}

public void draw_IO(){
  
  for(int i = 0; i < inputs.length; i++){
    inputs[i] = new Pin(i, null, 35, (0 + ((620 / inputs.length)/2)) + (i * (600 / inputs.length)), color(0, 0, 0), true, true);
    inputs[i].pin_size_local = 25;
  }
  
  for(int i = 0; i < outputs.length; i++){
    outputs[i] = new Pin(i, null, width - 35, (0 + ((620 / outputs.length)/2)) + (i * (600 / outputs.length)), color(0, 0, 0), false, true);
    outputs[i].pin_size_local = 25;
  }
  
}



void draw(){
  
  if(throttle > 0){
    throttle -- ;
  }
  
  clear();
  background(100, 100, 100);
  // Bisection
   
  fill(200, 200, 200);
  rect(0, 0, 75, height);
  rect(width-75, 0, 75, height);

  rect(0, bisection_height, width, height-bisection_height);
  
  storage.display();
  
  
  //Draw Circuits
  for(int b = 0; b < board.size(); b++){
    Circuit cur = board.get(b);
    cur.update_signal();
    cur.display();  
  }
  

  if(pin_click){
    track_mouse();
  }

  strokeWeight(0);
  
  //Draw Connections
  for(int i = 0; i < connections.size(); i++){
    connections.get(i).update();
    connections.get(i).display();
  }
  strokeWeight(0);
  
  
  for(int b = 0; b < buttons.size(); b++){
    buttons.get(b).draw_button(0, 0, 0);
  }
  strokeWeight(0);
  
  locate_pin();
  
  
  
  for(int i = 0; i < inputs.length; i++){
    inputs[i].draw_pin();
  }
  strokeWeight(0);
  for(int i = 0; i < outputs.length; i++){
    outputs[i].draw_pin();
  }
  strokeWeight(0);
  
  
  if(mousePressed){   
    bound_buttons();
  }
  
  draw_naming_text();
    
}

public void bound_buttons(){
  for(int b = 0; b < buttons.size(); b++){
    
    //Create
    if(buttons.get(b).text == "CREATE" && mouseX >= buttons.get(b).x && mouseX <= buttons.get(b).x+buttons.get(b).w && mouseY >= buttons.get(b).y && mouseY <= buttons.get(b).y+buttons.get(b).h && throttle == 0 && !pin_click && !locked){
        
        if(new_circuit_name.length() == 0){
          buttons.get(b).draw_button(255, 0, 0);
        }else{
          throttle = 100;      
          create();
        }  
     } 
     
     if(buttons.get(b).text == "CLEAR LINKS" && mouseX >= buttons.get(b).x && mouseX <= buttons.get(b).x+buttons.get(b).w && mouseY >= buttons.get(b).y && mouseY <= buttons.get(b).y+buttons.get(b).h && throttle == 0 && !pin_click && !locked){
        connections = new ArrayList<Link>();
        
        for(int k = 0; k < inputs.length; k++){
           inputs[k].state = false;
        }
        
        for(int k = 0; k < outputs.length; k++){
           outputs[k].state = false;
        }  
        inputs_inUse = new ArrayList<Pin>();
        outputs_inUse = new ArrayList<Pin>();
     } 
     
     if(buttons.get(b).text == "UNDO CONNECTION" && mouseX >= buttons.get(b).x && mouseX <= buttons.get(b).x+buttons.get(b).w && mouseY >= buttons.get(b).y && mouseY <= buttons.get(b).y+buttons.get(b).h && throttle == 0 && !pin_click && !locked){
        if(connections.size() > 0){
          prune_connections_list(connections.get(connections.size()-1));
          connections.remove((connections.size()-1));
          throttle = 10;  
        }
     }
  }
}

public void prune_connections_list(Link l){
  
   if(l.source.condition) {
     
     for(int i = 0; i < inputs_inUse.size(); i++){
        if(inputs_inUse.get(i).ID == l.source.ID){
          inputs_inUse.remove(l.source);
        }
     }
   
   } else if(l.destination.condition){
       
     for(int i = 0; i < outputs_inUse.size(); i++){
        if(outputs_inUse.get(i).ID == l.destination.ID){
          outputs_inUse.remove(l.destination);
        }
     }
         
       
   }
  
}


public boolean collect_inputs(Pin in){
  for(int i = 0; i < inputs_inUse.size(); i++){
    if(inputs_inUse.get(i).ID == in.ID){
      return true;
    }
  }
  return false;
}

public boolean collect_outputs(Pin out){
  for(int i = 0; i < outputs_inUse.size(); i++){
    if(outputs_inUse.get(i).ID == out.ID){
      return true;
    }
  }
  return false;
}

public void create(){
  int[] bitboard = new int[(int)pow(2, inputs_inUse.size())];
  
  for(int i = 0; i < (int)pow(2, inputs_inUse.size()); i++){
    String o = (binary(i));
    o = new StringBuilder(o).reverse().toString();

    
    int count = 0;
    for(int j = 0; j < inputs.length; j++){
       
      if(collect_inputs(inputs[j])){

         if(o.charAt(count) == '0'){
           inputs[j].state = false;
         }else{
           inputs[j].state = true;
         }
         count++;
      }
    }
   
    
      
    for(int q = 0; q < connections.size(); q++){ 
      for(int m = 0; m < connections.size(); m++){ 
        connections.get(m).update();
      }
      for(int b = 0; b < board.size(); b++){    
        board.get(b).update_signal();   
      }   
    }

    
        
    
    
    int sum = 0;
    count = 0;
    for(int k = 0; k < outputs.length; k++){  
      if(collect_outputs(outputs[k])){
        if(outputs[k].state){
          sum += pow(2, count);  
        } 
        count++;
      }
    }  
    bitboard[i] = sum;
    
    
  }
   
  reset();
  
  storage.storage.add(new Circuit_Display(new_circuit_name, 0, 0, inputs_inUse.size(), outputs_inUse.size(), bitboard));
  new_circuit_name = "";
  
  inputs_inUse = new ArrayList<Pin>();
  outputs_inUse = new ArrayList<Pin>();
  
  }
  



public void reset(){
  
  
  connections = new ArrayList<Link>();
  board = new ArrayList<Circuit>();
  for(int k = 0; k < inputs.length; k++){
     inputs[k].state = false;
  }
  for(int k = 0; k < outputs.length; k++){
     outputs[k].state = false;
  }
  
}
