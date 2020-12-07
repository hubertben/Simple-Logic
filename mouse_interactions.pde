
public float x_last_position = 0, y_last_position = 0, pin_lock_x = 0, pin_lock_y = 0;
public boolean locked = false, pin_click = false, IO = false;
public Circuit current;
public Pin source_pin, destination_pin;

void mousePressed(){
  
  storage.checkAdd();
  
  if(locate_pin() != null){
    source_pin = locate_pin(); 
    pin_click = true;
    pin_lock_x = mouseX;
    pin_lock_y = mouseY;
    last_x = pin_lock_x;
    last_y = pin_lock_y;
       
    
  }else if(locate_current() != null){
    current = locate_current();
    locked = true;
    x_last_position = mouseX - current.x;
    y_last_position = mouseY - current.y;  
  }
}

void mouseDragged(){
  if(locked){
      current.x = mouseX - x_last_position;
      current.y = mouseY - y_last_position;
      current.update_pins();
  }
  
  
  
}

void mouseReleased() {
  
  if(locate_pin() != null && !locked){
    
    
    destination_pin = locate_pin();
    
    
    if(source_pin == destination_pin){
      source_pin.state = !source_pin.state;
    }

    
    if(destination_pin.parent != source_pin.parent){
      connections.add(new Link(source_pin, destination_pin, line));
      
    } 
  }
  
  line = new ArrayList<LineSegment>();
  locked = false;
  pin_click = false;
}



public Circuit locate_current(){
  
  for(int b = 0; b < board.size(); b++){
    Circuit cur = board.get(b);
    if((mouseX < (cur.x + cur.w)) && (mouseX > (cur.x)) && 
    (mouseY < (cur.y + cur.h)) && (mouseY > (cur.y))){
      
      return cur;
    }
  }
  return null;
}

public Pin locate_pin(){
  Circuit cur;
  for(int b = 0; b < board.size(); b++){
      cur = board.get(b);
      for(int p = 0; p < cur.inputs.length; p++){
        if(cur.inputs[p].distance_from_mouse()){
          return cur.inputs[p];
        }
      }
      for(int p = 0; p < cur.outputs.length; p++){
        if(cur.outputs[p].distance_from_mouse()){
          return cur.outputs[p];
        }
      }
      
  }
  
  for(int i = 0; i < inputs.length; i++){
    if(inputs[i].distance_from_mouse()){

      return inputs[i];
    }
  }
  for(int i = 0; i < outputs.length; i++){
    if(outputs[i].distance_from_mouse()){

      return outputs[i];
    }
  }
   
  return null;
}




public float last_x = 0, last_y = 0;
ArrayList<LineSegment> line = new ArrayList<LineSegment>();

public void track_mouse(){
    
    strokeWeight(5);
    stroke(0, 0 ,0);
    line(last_x, last_y, mouseX, mouseY);
    for(int i = 0; i < line.size(); i++){
      LineSegment l = line.get(i);
      line(l.start_x, l.start_y, l.end_x, l.end_y);
    }
    strokeWeight(0);
  
    PVector dir = PVector.sub(mx(), pmx());
    float magnitude = dir.mag();
   if( magnitude < 2){
     line.add(new LineSegment((int)last_x, (int)last_y, mouseX, mouseY));
     last_x = mouseX;
     last_y = mouseY;
   }
   
   
  
}

PVector mx() {
  return new PVector(mouseX, mouseY);
}
 
PVector pmx() {
  return new PVector(pmouseX, pmouseY);
}
