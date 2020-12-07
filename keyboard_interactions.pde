
public void draw_naming_text(){
  fill(255);
  textAlign(LEFT);
  textSize(40);
  text(new_circuit_name, 85, 640);
}


public void keyPressed(){
  
  if(key == '\n'){
    create();
  }else if(key == BACKSPACE && new_circuit_name.length() > 0){
    new_circuit_name = new_circuit_name.substring(0, new_circuit_name.length() -1);
  }else if(key != BACKSPACE){
    new_circuit_name += str(key).toUpperCase();
  }

}
